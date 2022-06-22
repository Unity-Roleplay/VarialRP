var colors=[
  ["#e8a859","black","#d77","#ff5e5e 0%,#bd1929 38%,#0e0000 100%"],
  ["#ecd252","black","#7f5","#64e25e 0%,#098022 38%,#051700 100%"],
  ["#f779b3","white","#29f","#64a4c4 0%,#1c5d9e 38%,#1c0935 100%"],
  ["#947def","white","#da4","#ffbb5e 0%,#b14b03 38%,#350f00 100%"],
  ["#4c9cff","white","#85f","#ae41cc 0%,#53136d 38%,#000000 100%"],
  ["#6ed662","black","#ddd","#e8e8e8 0%,#a0a0a0 50%,#1f1f1f 100%"]
];



  var colId=2,image=8;
  var ci=localStorage.getItem("colId");
  if (ci!=null){colId=parseInt(ci);}    
  var bi=localStorage.getItem("image");
  if (bi!=null){image=parseInt(bi);}



  $(document).ready(function() {
    ChangeColor()
    SetDefiniçoes()
});
 




function SetDefiniçoes(){

    document.getElementById("specCols").innerHTML = ".twitter-new-tweet{background-color:"+colors[colId][0]+";}.tweetuser{color:"+colors[colId][0]+";} .twitter-new-tweet:hover{background-color:"+colors[colId][0]+";}#contacts-submit{background-color:"+colors[colId][0]+";}#contacts-submit{color:"+colors[colId][1]+";}";
    
   
  }

  function ChangeColor(){
    var inner="";
    for (var i=0;i<colors.length;i++){
      inner+="<div class='coloroption' "+(i==colId?"selected":"")+" onclick=selCol("+i+")><div id='coressettings' class='col' style='background-color:"+colors[i][0]+"'></div><div class='col' style='background-color:"+colors[i][1]+"'></div><div class='col' style='background-color:"+colors[i][2]+"'></div></div>";
    }
    document.getElementById("colorbar").innerHTML=inner;
    
    
  }

  function selCol(id){
    colId=id;
    localStorage.setItem("colId",id);
    ChangeColor();
    SetDefiniçoes();
  }

  function selIco(id){
    image=id;
    localStorage.setItem("image",id);
    ChangeColor();
    SetDefiniçoes();
  }




class PhotoGallery{
  constructor(){
    this.API_KEY = '563492ad6f91700001000001550f5033cb5744d3ad20f1b547e6dc36';
    this.galleryDIv = document.querySelector('.gallery');
    this.searchForm = document.querySelector('.header form');
    this.loadMore = document.querySelector('.load-more');
    this.logo = document.querySelector('.logo')
    this.pageIndex = 1;
    this.searchValueGlobal = '';
    this.eventHandle();
  }
  eventHandle(){
    document.addEventListener('DOMContentLoaded',()=>{
      this.getImg(1);
    });
    this.searchForm.addEventListener('submit', (e)=>{
      this.pageIndex = 1;
      this.getSearchedImages(e);
    });
    this.loadMore.addEventListener('click', (e)=>{
      this.loadMoreImages(e);
    })
    
  }
  async getImg(index){
    this.loadMore.setAttribute('data-img', 'curated');
    const baseURL = `https://api.pexels.com/v1/search?query=nature?page=${index}&per_page=12`;
    const data = await this.fetchImages(baseURL);
    
    this.GenerateHTML(data.photos)
   
  }
  async fetchImages(baseURL){
    const response = await fetch(baseURL, {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        Authorization: this.API_KEY
      }
    });
    const data = await response.json();
    // console.log(data);
    return data;
  }
  GenerateHTML(photos){
    photos.forEach(photo=>{
      const item= document.createElement('div');
      item.addEventListener("click", function(){
        document.getElementById("tela").style.backgroundImage = "url("+photo.src.medium + "&w=1366&h=768" +")";
        console.log(photo.src.medium)
        $.post('http://phone/wallpaper', JSON.stringify({wallpaper: photo.src.medium}));
      })
      item.classList.add('item');
      item.innerHTML = `
    
        <img src="${photo.src.medium}">
        <h3>${this.searchValueGlobal}</h3>
      </a>
      `;
      this.galleryDIv.appendChild(item)
    })
  }
  async getSearchedImages(e){
    this.loadMore.setAttribute('data-img', 'search');
    e.preventDefault();
    this.galleryDIv.innerHTML='';
    const searchValue = e.target.querySelector('input').value;
    this.searchValueGlobal = searchValue;
    const baseURL = `https://api.pexels.com/v1/search?query=${searchValue}&page=1&per_page=12`
    const data = await this.fetchImages(baseURL);
    this.GenerateHTML(data.photos);
    e.target.reset();
  }
  async getMoreSearchedImages(index){
    // console.log(searchValue)
    const baseURL = `https://api.pexels.com/v1/search?query=${this.searchValueGlobal}&page=${index}&per_page=12`
    const data = await this.fetchImages(baseURL);
    console.log(data)
    this.GenerateHTML(data.photos);
  }
  loadMoreImages(e){
    let index = ++this.pageIndex;
    const loadMoreData = e.target.getAttribute('data-img');
    if(loadMoreData === 'curated'){
      // load next page for curated]
      this.getImg(index)
    }else{
      // load next page for search
      this.getMoreSearchedImages(index);
    }
  }
}

const gallery = new PhotoGallery;





const tela = document.querySelector("#tela");