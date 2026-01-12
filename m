Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E234D928
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216858; cv=none; b=lzrxywgY5NAcGn0z8gMIo6LLAHl52wmj2OvxgCkcpAqB3wrep3pQ9edZzNOw6Us/ApAbw7XHfneyGjes37Hah+5BfGZstUt9JlpdesnOxAJxgQFFEg+U1iK0FTjstxpN9mtB+0rlJk81KFL6qHOYi0O/nsD/0YNXKXlJ0ru9UXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216858; c=relaxed/simple;
	bh=80vDx172K38JVXXoGjjGExixmhv72jasiNuq6fEFSvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAt8yE5EsL7WUqNI7hCXGdgP/WlFya9X7QwyGJveUoo6kZFi81hkbeJz73oId6S5gzShRPY17iOGU3P17AzwGfQP1DVkOsT2kI8QdQ3FCdN1T/kuqorAJz3Og8uwd0i/jVbptkCKuQ9H7T4OJUMC565QrVLaklCdgOVXds8cuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxBM+eon; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxBM+eon"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430fbb6012bso5018650f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 03:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768216856; x=1768821656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSljOrgcnpMxKsFMt7qzzrVtZrbIJt+W3Zu8aaC1wcI=;
        b=YxBM+eoncBVOKzhkYc13f1lmEgYwmVL/2RPvhBZkGU1+GBJJyFU16T0YFCakIH68vi
         CJenDamjb6+KXMQHChYoOQ9f+oN3MtbjWcfj20MynZtgscbLRSrXppR/yEACL9tn4Rbl
         5JL+f88PO25Yaa3yhtQWjwWFYMYSbdRU2A4tHO91ihJeWNFGDh1Mif1xQCuHaGmutyD7
         JBak6hR6kX6vRtKGakOJo4fPK19LjvGPl07XaZhZaUUSsvUyI1XLnXI55nxXs2cjoyBF
         QD0NjOkHvhF0CLicxh9HAyrN1JUoBEEIPtRIPRKWFBRFRs7OkZ30bS11GZvTj5lJLqdo
         if0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768216856; x=1768821656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSljOrgcnpMxKsFMt7qzzrVtZrbIJt+W3Zu8aaC1wcI=;
        b=QAbpzLTOf/vL4I42nIH0Jrlngs3jmVgqOIUPW515H2NbAHiJe2YFw0ODSqFzAV9Pn9
         vSdzt6PsLGPs8knAUpludBb5nhIKHGBKOJnuF/tpDIb/aagpBnvFAixwjbsRyRt0ClDJ
         VY/rwxN1/0gtCX+cWRmaQCbGF+w9EggStiVJB2GNtu055dTLM+NONC7I23GcO2+5r4A/
         ETROTIOMTmgXbAL/Wgu44HGgHU4OizY0oCA0WnBSlnlFymdNtr0Yq3pT5xkG2ueHbyRN
         2YX4eAgxfCrtU35cddIvGghfu5meFFQGnK6Uf74yx4R6fIptroarl4ODqTFT8df7t4Cg
         B1ug==
X-Forwarded-Encrypted: i=1; AJvYcCUOf7E7SoaQzyrijfz39znfIRZwhiI4nc6DD6LXfaBWRL3sfqwSzmA6P7fEfScQfBT8NAhZOM6juxPU/LxMTqxn+ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCtva7Pw4R8mloQqXhaRpsMGcB/TUH0ztvcs5xnepylwbVWMm
	rcCE0M+x3wgjSM5qHQrlNMR1OWtJPiz1WZfacWinzdLWCqUWGP3ZRGJFMq1lprn8ytQrCOofTai
	MwFpBECy4xkVg1mlywwr0YElnJwSh1sVZuITl8pZq
X-Gm-Gg: AY/fxX5PnJDGu6L0ncrxK1/wh38uX+RQJPIWqeENfk5xUiLvdU9fhZM+Bw40NoiPWN2
	cN5fcI93W2H925ZR/v3fzIK5xpdYGE0WoaL3d+KRHoIlrrDljyhjD1JGmgHjrEJ3AaEy94Q42Ua
	0n4PRyD/GWocWwxTqAREtfbfxUbUftVmhgJVV+M9BTPzvD7Vc5Dn+fI5XOfwOFb+5yNu3LTQGp5
	UqhsC+EwN98PwcU0v1ksr1i6PxiFR1F1EMSOIv3rvPA8AYVV/pZ+r++iyf2RXhAlQm5XJWNg5bx
	icvZf2vEiW2xd9s7e5C3PMif2d7raJc4oropyVS1rxqlsf56Ut4X6hHDO0I/nN2YUJo0
X-Google-Smtp-Source: AGHT+IEN8r1RmzogxIovaxQkpXNvQjt43QOedMNAYUrKwophbrZqVbqY224onR1X4LMrOo4+y4R2b5xO+sJ2UoLQYcs=
X-Received: by 2002:a05:6000:3106:b0:432:c0b8:ee58 with SMTP id
 ffacd0b85a97d-432c3617c2cmr17668239f8f.0.1768216855538; Mon, 12 Jan 2026
 03:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWS9nOj4MAa7pYmS@google.com> <20260112100059.12139-1-fushuai.wang@linux.dev>
In-Reply-To: <20260112100059.12139-1-fushuai.wang@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Jan 2026 12:20:43 +0100
X-Gm-Features: AZwV_QhCAzGudvn1k2e6DHog-YXcuhXd_Z2Wyyrhc08Dhs8X2lfNXe83_kk2vqE
Message-ID: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	cyphar@cyphar.com, dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, 
	kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, luto@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, tglx@kernel.org, vmalik@redhat.com, 
	wangfushuai@baidu.com, x86@kernel.org, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 11:01=E2=80=AFAM Fushuai Wang <fushuai.wang@linux.d=
ev> wrote:
>
> >> From: Fushuai Wang <wangfushuai@baidu.com>
> >>
> >> Many places call copy_from_user() to copy a buffer from user space,
> >> and then manually add a NULL terminator to the destination buffer,
> >> e.g.:
> >>
> >>      if (copy_from_user(dest, src, len))
> >>              return -EFAULT;
> >>      dest[len] =3D '\0';
> >>
> >> This is repetitive and error-prone. Add a copy_from_user_nul() helper =
to
> >> simplify such patterns. It copied n bytes from user space to kernel sp=
ace,
> >> and NUL-terminates the destination buffer.
> >>
> >> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> >
> > Hmm, this function is very very similar to strncpy_from_user(). Should
> > they be using that instead?
> >
> > Alice
>
> The strncpy_from_user() is for NUL-terminated strings and stops at the
> first NUL in userspace. But copy_from_user_nul() always copies a fixed le=
ngth
> and adds a NUL at the end in kernel space, even if userspace data doesn=
=E2=80=99t
> contain a NUL.
>
> So I think they are for different cases and can=E2=80=99t replace each ot=
her.

strncpy_from_user() succeeds even if userspace data does not contain a
nul. Then it reads length bytes.

As far as I can tell, when a nul byte is present, none of these kernel
use-cases use data after the nul byte. So the behavior is identical
except that copy_from_user_nul() may result in EFAULT if there are
unmapped bytes between the first nul byte in `src` and `src+len`.

Alice
