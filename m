Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFE2DA75A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975847; cv=none; b=lEj4VaTBv2AJl+uJa21bNvdt56U/vCqy2zQvgYIKlhEHqOFdKP/PhO8aiRbYOs1HOnxWvQJE1d6vpD7IstV9mueSojAV7tyZljk3D0cGg1hVYurpZ9+x91mb58h7kQNrI/sw3D0B6k8ZhoaibHa4N31ounYn7a/VIAj4jXbTwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975847; c=relaxed/simple;
	bh=TEHRtld4Bg238zzuQf4UOHuFAEYFthjxJQB/qIWOQb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xuj5PSKAPK1gGyQMLSxp44K90xdBu6Ww+KLHb6yL8/sjPjtNemgorqKSXAqJOgscy49U7Ko+bjIRmpmrBSdp7vYKtBrUbKpqATqwHX9h/YEymXnAxeO4BaE0li9+LkgAi8rMSIw58OiCfqKpVFVRfk05rBeLv2QnUs+6wkpvQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXkBxnIG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXkBxnIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751975843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TEHRtld4Bg238zzuQf4UOHuFAEYFthjxJQB/qIWOQb4=;
	b=aXkBxnIGyRtJ+AhktrBgZEXQUM5b5uzILDUiNF45R/Rq2XO4t+5hvdUNFArdOh0g0r/G0o
	J9bSNPcPhpBmBhAn+FwBM7uOMv2ZnON+sooiDoiiOzfXuvBtd9ogDit8JoD49TSpO++Wjt
	CZJh27/9++ofuKxm2ct6GW76qkqRLm8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-n_XFiNzgMsW27ZSq2YPHng-1; Tue, 08 Jul 2025 07:57:19 -0400
X-MC-Unique: n_XFiNzgMsW27ZSq2YPHng-1
X-Mimecast-MFC-AGG-ID: n_XFiNzgMsW27ZSq2YPHng_1751975839
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b39cb4ca2eso1669483f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975839; x=1752580639;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEHRtld4Bg238zzuQf4UOHuFAEYFthjxJQB/qIWOQb4=;
        b=TcRx3KFMQK8dHCG6BFtTgzbNGxooAPVEukMDhBMy3jxZjNqs3EP3xLFrTgBgjLHQZJ
         O+VZX5/Myzm0N3ibtL6hGhQIQS26yhMkdG25wjBDdvA7umACmj0kkUViyo6hQEjFR9yI
         1E8vVTLNQDsqAigMCP97PEYGSJ8O2ftexEoqp40ToAscHdwr8w6qdkJVeXWj9o5o4K2V
         GQZtdwAK0939O9D/MnRvgT1QneUm2pMVTOkNfce58DAKGlI65kaRazBFGVpAMNGBoSU9
         AxEHestZZxsn46a+xiqKWOJvuMUNNmNtOC6S5BuzgFTZ0r64HpkMMZ+mxW0HpDwHRFkh
         9R3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLmG3dk7H0E3NZSpUAPm7gdHTscfsCzhj5JVK/j4jdyHTBaEX95POJnYl9v6nl9CD+94CmeTyiB6L27RCPHpzo5fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEXNwpsuQnoxgsbbeWL7MJMCafHbqX8JhIRwGc0wmC8iCpSVo
	iP56RbHL+cBCxxNopWE86Ae4VX3bTbygv9C8Mw7TxFaH6/aAyvBic46ZmuKRbTGDIH0bpUK5IWt
	gqZtx3OcFcnH6ppARhle13gToowzQr1Owg/WzmIbi2rg+zH3FCk/YPJK07Mj9yWBeBglWmrDGIQ
	==
X-Gm-Gg: ASbGncuTq4wl+Vf9jkZ7RuP41v3NV/rs49tivKxVBjUUZxkdBNGWEpeeM1kRdh5HdDV
	XgWxINcIiXgvOFq2mMiHkNgouuJAUmtc4XYNyh6v+wnII7FqyQkNxXRfHBG2OqgfLK+F4duQPj+
	Duvu0E5dK02wUXW4PXVn/Xgplww+yDNCvgKrJWxaIvZ3vCZDkeDfLxj5Uc1o1iRUKBrGfqDbeOe
	o6HN/7T9JMdLBLWxARxOjtnDW7XKWwRZ3bsGq+sAQFK+7zBXiKrO8653pNn0KvROD0bqaSIVXDm
	a7ujC4MI/g2O1RFqtzPRUZFY7T6lx/DcW65+52qzknNBrae9
X-Received: by 2002:a05:6000:1448:b0:3b3:a6c2:989 with SMTP id ffacd0b85a97d-3b4964c0b49mr12317312f8f.18.1751975838572;
        Tue, 08 Jul 2025 04:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeV+wFJfih7QmPEI1qBN+NBuVr8+EOK+jd+4ay3Umcy9zqCyOhcpQ/07x3fscV34Qu9G4b9w==
X-Received: by 2002:a05:6000:1448:b0:3b3:a6c2:989 with SMTP id ffacd0b85a97d-3b4964c0b49mr12317294f8f.18.1751975838102;
        Tue, 08 Jul 2025 04:57:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d8107sm20458785e9.34.2025.07.08.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:57:17 -0700 (PDT)
Message-ID: <cd8e42bdf86c3d4f2da8b7636d3b35cfead2c3c3.camel@redhat.com>
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Date: Tue, 08 Jul 2025 13:57:16 +0200
In-Reply-To: <20250708075013.hMCRH87n@linutronix.de>
References: <d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
	 <20250630203401.1a11e58f@gandalf.local.home>
	 <20250701051757.mBjQVdoo@linutronix.de>
	 <20250701110218.5e742850@batman.local.home>
	 <20250701110551.5c2dc2ee@batman.local.home>
	 <20250701151114.OJQTlRCY@linutronix.de>
	 <20250701111704.00456667@batman.local.home>
	 <20250701210338.BooVbo54@linutronix.de>
	 <20250701171715.5a1a99a0@batman.local.home>
	 <309ecabeacc72f13de7b190f37423f1aeafe991d.camel@redhat.com>
	 <20250708075013.hMCRH87n@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wc0eR-U7hOlwJ9M4ffKBTfyCQVQN2pjTgLA4sVF7TWg_1751975839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-07-08 at 09:50 +0200, Nam Cao wrote:
> On Wed, Jul 02, 2025 at 08:29:28AM +0200, Gabriele Monaco wrote:
> > That's a good point, at the moment the DA monitors have a comment
> > in
> > the /completely/ generated files (the automata header), the others
> > where just a skeleton is prepared have some hints that we removed
> > while
> > filling the monitor.
> >=20
> > I'd say for now it's good to just add a comment in the LTL header
> > (like
> > Dot2k:fill_model_h_header), then we can adapt all generated files
> > (whether fully or not) to have also the actual command that
> > generated
> > them starting from the model file.
> > Or did you have something different in mind, Nam?
>=20
> Yes, I think the same.
>=20
> An easy way to do it is just dump out sys.argv. But one thing I'm
> unsure
> about: I prefer to execute the command from tools/verification, and
> the
> command I use would not work for people running from root directory.
> I
> would like the printed command to always appear as if it is executed
> from
> root directory. However, I see no elegant way to do it - will need to
> think
> some more.
>=20

Mmh, that's something I didn't think about, but perhaps we shouldn't be
too picky and think users would just copy-paste the command provided
and expect it to work.

By the way, the sys.argv could be a great start, but depending on the
workflow, one may not even keep the model in the location where it
would be committed during generation (I usually don't, mostly out of
laziness).

Anyway, although I'd prefer running the command from the repo root,
just for sake of compactness we could include the command as run from
tools/verification, but I'm fine either ways. I think by adding proper
documentation, the reader can easily figure that out.
We could edit sys.argv before printing to make sure the model is where
we expect it to be, and perhaps strip/add some arguments (e.g. if we
want the -a or not), just to keep it always consistent and predictable.

As long as the command written to the files is consistent and clear to
understand, I wouldn't mind too much.

Thanks,
Gabriele

