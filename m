Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5115A4A0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567759; cv=none; b=UODanEdKE6+RjaSYJVl+SRHj557EdfC3d3VD7SmXODgtR+NYfXrsJVlOJYShgEqSxvUMUtsAlIOzDPLLkM+yxLkfX5prE5ge9ijYit9We+GGURKKaNxjAAlevuu8vIWSTWYHOODurrRzwyZmE7AnatWFwXSrhRXwOhoQ+xCDgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567759; c=relaxed/simple;
	bh=VnTiScXQo7bZZSg4GpsGPNgsG9aIQqnuAmV4bkEVHE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3IZzfCM5CgTF9bAjB3rt7Bp5gpz/bGSAOj2Do+8zggERkSqPs29qaYhywUpyFp9n2dK52gXRBMZkT6U2VnuP7/GKfnkvsVaJUVJPX5avFDvoaRyTHjN3SrFKbvESnYu8NrbMjSb7N7Mk7e+1rS0hbhtH4M8JN3z4148JsEl+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C7XpMCIP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C7XpMCIP"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5110d0b1af7so2599845e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706567755; x=1707172555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hj+C8eVFms56HSNUtGD4vDso2zbX9G6i0iFWoHn8+w=;
        b=C7XpMCIPLV3aBXlRpK/jSod7hMEzchvQUqK7g+DKNPBMmaUd4+MoIt+5JzQOHyQSjU
         jbkV7n8KpR2P+w/i28qeZt3cmjiVSEtvRu1iEniWF0ha6ZXZM0lkxWwoxzadf8LLomj6
         RNiltSzVL7i51n4z6OF/XH8UPTbF2IcCrUMmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567755; x=1707172555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hj+C8eVFms56HSNUtGD4vDso2zbX9G6i0iFWoHn8+w=;
        b=SeBBkkHrlXR7FogZGOvYtlzKUn+yhONLdZTBAQUPrnINdi2ALhs5jCL4l8iCwd0fVG
         PcKrR3jNgdj+8I176ZUWwebzFEunrg9Hn2GGr8KlwrCidD2zxIsmVyPQS10IHBUbUkKB
         N+rNgbpYmJl3CEHJiUWHNVUqV9DqKSW8Ua8eA5+1a2rqdEKsoEzkIiJy8S9f9AhhJrc1
         zQB9vqn+wx5zBs1sUTfYyexi7usX8qe45XsCWf0kF3RMkWv0jwcu/nKy5ZCClk/47mcf
         NGTnzXygr5WY2QrdMA8VV00kIH3gEnq/rW49uP4fHbzfJeNCKeoWFe7xH4pSmqPCddRZ
         vNNg==
X-Gm-Message-State: AOJu0YyjUjFk3gHtWQFE1QVNKOHdU9FiDU/hwnVpap+B/+4m1hreLq+Z
	HwQzALEPTNbAXQrOnijmoTb2aou+yGoT3tpyFtDTsIvZp/TJF3dVzItqs9j78+jP3XCY6wjsMA8
	OV/s+8g==
X-Google-Smtp-Source: AGHT+IGhMT0bG7sSMHnoTEkLks9jSU1G4C7YSwq341Cjt6C7uqvNFUfZdA1+W4F6CSk5PTQds6TYYw==
X-Received: by 2002:a05:6512:2353:b0:511:15ff:5628 with SMTP id p19-20020a056512235300b0051115ff5628mr1946445lfu.22.1706567754874;
        Mon, 29 Jan 2024 14:35:54 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j1-20020a056512028100b00510171b4270sm1219763lfp.137.2024.01.29.14.35.54
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:35:54 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d043160cd1so20645131fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:35:54 -0800 (PST)
X-Received: by 2002:a2e:9a93:0:b0:2cf:22f1:bd5e with SMTP id
 p19-20020a2e9a93000000b002cf22f1bd5emr4180113lji.44.1706567753589; Mon, 29
 Jan 2024 14:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home>
In-Reply-To: <20240129172200.1725f01b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 14:35:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
Message-ID: <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 14:21, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But crashes with just a:
>
>  # ls /sys/kernel/tracing/events
>
> [   66.423983] ------------[ cut here ]------------
> [   66.426447] kernel BUG at fs/dcache.c:1876!

Duh.

That's a bit too much copy-and-paste by me.

So what is going on is that a ->lookup() function should *not* call
d_instantiate() at all, and the only reason it actually used to work
here was due to the incorrect "simple_lookup()", which basically did
all the preliminaries.

A ->lookup() should do 'd_add()' on the dentry.

So just replace all the d_instantiate() calls there with "d_add()"
instead. I think that will fix it.

Basically the "simple_lookup()" had done the "d_add(dentry, NULL)",
and at that point the "d_instantiate()" just exposed the inode and
turned the negative dentry into a positive one.

So "d_add()" is "I'm adding the inode to a new dentry under lookup".
And "d_instantiate()" is "I'm adding this inode to an existing dentry
that used to be negative"

And so the old "d_add(NULL)+d_instantiate(inode)" _kind_ of worked,
except it made that negative dentry visible for a short while.

And when I did the cleanup, I didn't think of this thing, so I left
the d_instantiate() calls as such, even though they now really need to
be d_add().

Hope that explains it.

And I hope there aren't any other stupid things I missed like that.

         Linus
