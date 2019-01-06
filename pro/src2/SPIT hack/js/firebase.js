import axios from 'axios';

const instance = axios.create({
  baseURL: 'https://certificate-verification-faecb.firebaseio.com/',
});

const data = {
  fname: 'Farhan',
  lname: 'Kasmani',
};

instance.post('/name.json', data)
  .then(
    response => console.log(response)
  ).catch(
    error => console.log(error)
  );

instance.get('/name.json')
  .then(
    response => {
      const data = response.data;
      console.log(data);
    }
  );
