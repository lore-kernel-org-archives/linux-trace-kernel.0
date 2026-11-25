Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625056;
	b=xh9xXIowqx+827rG8otNWmh9zFGuetcUrtR1Q9mzshD8DUy50kChFoImPvr0WXLKAabz
	 QfwJv2wkLyqsvcPoK29JyeR2cMCrt0bfiukIfX0M5exCC+XYyS1l80/qNCZbxXuiBc76O
	 iBdfmwmnDLU10VDMUIIeB3Vbg66lbsa/tyCzQ3pzTXDO9RHBLvtszH3h+cu4K71w0pV/9
	 VzTzXnpE3ec3bwRcBwaFB7oVZA2c8jVA2mRZNQnUzd11R98Kau8JRoY5ToKhwkSrA37xL
	 AePPF/AF2c6ljg5Twy38aLd20IBg01qZFQken1KrucWI+56X26pmrh3svM9M3S3XlOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
	b=DAS07aXFiwPj+mpMGFAkHWlvAsllmU6sEx60bpkkruvuFEIyKrjKSUMPDGAEmc7AbrLs
	 0nQFOaDKQGm/6H3ZbAbLwKQw4BM5qnJe9toFT7Svw8ZVrGdPzbmoFskuvHAox3Oz4qg14
	 NgK49lTM4dQRJSwxnx0pDk/xMgVQ00+zMoJYYZFKD6VSImtc04My4d9TA8pZObwpOgm+l
	 1EkJPVIK5qvsZev89wnjPS8m5w8h0mHOt+7RNOg6YO9feweCpibQCyGk9dTvvmuThJljH
	 bbP7lS5XkzDzI7ri6VTcCm7EBAmv+mqLjj9fr9gIrroZ4Xl2irsy6/qhgTFxDqWSewg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D263606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D263606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c51a02ad3acso146647866b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 08:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625054; cv=none;
        d=google.com; s=arc-20260327;
        b=NQftusyCHnL3HkFf3kriHxqseKerRQ8xQ2H5JZ23iD2ryYrwTtiOxHdlALFnyBOBoB
         W55X+jJScjF3Oc+CaWPgh6wTkBpua3gfIRXgz71z6HL2jR12ziYyMONK0w0ISN+XlnBL
         izhBg1DKAFWUI/3CuoQDycUXWOs/F6gb9lzZUd7bzoyq7xarF24jUGOv9vMtWJGB5L2L
         Zx9wjd3udQcU2bmRl+XrfT3FLkeN9OEe1y4ZX55QQj02ReOTZzWExt5MnPEPshakWmHY
         bzOuX8xG8UCR39poxiLFi6ypzBjXQ8GDgsjWXtoOO/pV8JVxe9HAnB74TYw6qd40opqs
         AaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        fh=TGtzafSazZHa1D1FbIZqmyn+lnfoUTq7zX96ZhcAoVU=;
        b=LRm6wvboO6xDE13o8dd6i2Gp5k+aHWU5f/1OobV1KvSpXtm4aOn2O/CXOg9GcvKQKE
         I7op6ZW3qqGJEBm660OhBtHA3T/Jtt9rv0VOcDPEYS9Mb4ThIiCcEaTtS1do5FFiFRIb
         7hLfxL7tLpu8QzYeyEpgxXjDWmf7SHsY0DiUkmQOt9fQWi+X944sEjsMCB2rToyXRQs6
         xYb3652+r4K7rxJkWNQrdNV/aPaLSMxkrLN51ghzNIaLuAdFfJEOCttUxvGNwX3FG3up
         IlxZSCesmUH92f8uInSZkcjgy2JiOkNy6E+MLOhI5pNra/s35UU5AFquH7FHoqjqSJIT
         0QCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795625054; x=1796229854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=PKZ23RQeMEttotX4OBPRP2DbbrMEB51nwAQlsHi3Clsl60+KLwydytyVzIwS3CPrsp
         gMCa0qLojqUmZPTj1WgDWb2vfDDzy8I3ouZC6AtzVQzGhYkAtsdS7I194LfKbKzPHVBH
         9FjnQKv/TdlaTy27yqxtS+FRu+TCtlSdjsR4QOyB9tkMnDrs00BEwfTTEGdJNrrE0d1S
         i0G3BgU+8ocwt4ScMKi+JN47+02WlDqK9aHu8g0fQCVcWCnmaTG9N306L0mPKog4H/f4
         BgsXgGhnHP8RFqRdmh8kRVgxVbHO2JS8qa43xqFnpf9P4Z4Esbd1QfxvoHuOMiibIYtV
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625054; x=1796229854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=VsptXbFsJNTltTde0euLxcm0fvWfP1UVIy6oXIg6SEqVbbNS+25oIucAv6nbNThCFv
         abcgmJqRsKGlkqghSkzRB58p/SCdtV2o9dNFeoERbNf0ckMfnXnKq7b08kTo1zmFQJ4+
         /iTOKKAH3dN5MwiYVygwBJxHI8HcOFl4oMMCGoOeLpGo3X+SJf3ed3HQMZZ9duF15MMG
         ZB8MHYBciXidqCldlCh/FaH6Zvjw5TE6Y5tTEgQjs4LRFhXKikpzc7RHRAJSwWrmpFbO
         ZNGiETJ3xWBexNsx0CD5l1AFs63cLsDHnCyTFZR4y47qaS7kTAlzdbYcnkQWazPbAk7u
         gN6A==
X-Forwarded-Encrypted: i=1; AL+hErGmc7m5vQQwMqo0x+1CRPdU7Ex5G+IRK54oWCx0iwEyhk10uc3c3allR/DKBQozlmcf6FoAN/9OoGtbzY/lY4Aegm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yKVqRPRl9ICiVsvHk9u/9uWfDy1XK3p5ZXXUju6eyn9QKZNyf
	pVKpz7dBZwEz73crhGb11Nipo8VAaVyqmen1WT3I11XNE8eRniq0Tegvs/0u/jddZ0vtdpbzpPv
	uOZW6HJpkA+HEHVbpH6Kh/JmSSdbvaauQC1wBw6TN
X-Gm-Gg: AZFdTZcIulVpI5T/3SbeCsfMyvkL3MI1bbtay3je9WDeJVDhORadCJBtc2eRruYk/ji
	gKNDCavfGbF0BFr5i+17CJvPAMyNpnxxRtQlBHhAdc14Ya5IMc5eQUIJYHnATfXSmgS/CKXjQrh
	9ReVTpte9jRb4qXxcnj6W7ZQ58rM+bfiiAG9b4A18GOmVlIFwFiXwoe59hzRIeM+ArqflGc4m4x
	7xrrylxtOT4rZx+2z2mwwZBmxn6Th3auLGEf+pnmIUNVrb7B9TMIWr+v7mFwPMbuhu8BfxRrd/r
	6ZagBSx6LFocU21M+37kWB4QPZ6aPP/u1YfrJ7CUv1RljL4YT0F6AhywSY/VQbBvwGBIoMKkICm
	Y0RKjqp/X8fVv7mDL/ne+vmdVlUOPZa9NOU4qD9DkvSK6XwePmdfjyWrtz5VfedGSX1Dq4rJgsj
	Tk62sqw32UeG8iwXIpUsDtu4SYQdDTzsH1iijgP/iJtxCNqY0L//k=
X-Received: by 2002:a17:907:6d22:b0:c51:40e:847a with SMTP id
 a640c23a62f3a-c513a1e6fdfmr1639688066b.0.1795625053094; Wed, 25 Nov 2026
 08:44:13 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ac22215d-3e58-4aab-851e-47c30836e058@app.fastmail.com>
 <20261027231728.1466446-1-jthoughton@google.com> <32fad21b-5bad-4640-97df-ef0f638cd9e9@app.fastmail.com>
 <CADrL8HX5vb1PGDpWzp-eR0rNfsMCVUhFa9vp_WZZx2eJZ+dfXQ@mail.gmail.com> <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
In-Reply-To: <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 25 Nov 2026 11:43:36 -0500
X-Gm-Features: Aa3M54qTCDON0Zo2YJDXp5pBtwrXjTcYjv8NoqDjQS_XV_tl8JrBb-LQVlKEL3Q
Message-ID: <CADrL8HUOZs-vWRyM9p+Na-=arRU+Gx_cWMLbxHmUYnho4fAUXg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, kvm@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Nov 24, 2026, at 22:10, James Houghton wrote:
> > On Wed, Oct 28, 2026 at 7:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Wed, Oct 28, 2026, at 00:17, James Houghton wrote:
>
> > So now in v2, the _nofault() helpers themselves do not check current->m=
m.
> >
> > I've uploaded a draft version of v2 here, in case you want to take a lo=
ok:
> >   https://github.com/48ca/linux uaccess-v2-wip
>
> I read through this now and it all looks good to me so far.

Wow you looked at that really quickly, thank you so much!

> >> Since in principle every user access should go through both
> >> access_ok/mask_user_address and current->mm check at some point,
> >> so combining the two as much as possible should help long-term
> >> maintainability.
> >
> > You're right, and v2 has been restructured like this.
> >
> > - The check is in access_ok() itself: the generic version, plus the
> > arm64 and riscv versions. __access_ok() remains a plain range check.
> > - The callers of mask_user_address()/masked_user_*_access_begin()
> > check current->mm explicitly. There are about a dozen such callers.
> > - The unchecked accessors, __copy_{from,to}_user()
> > and__copy_{from,to}_user_inatomic() (and arm64's
> > copy_from_user_flushcache(), which also relies on an earlier
> > access_ok()), keep an explicit check for now. Once their users are
> > converted to the checked versions, those checks can be dropped.
>
> Ok, sounds all good. If we get more than handful of mask_user_address()
> and masked_user_*_access_begin(), we can always revisit that interface
> to make sure the check can't be skipped, but for now this seems
> like a good tradeoff.

Great!

> > Compared to v1, this also covers get_user()/put_user()/clear_user() on
> > arm64, powerpc, riscv and the asm-generic architectures, and arch code
> > like signal frame setup that uses access_ok() followed by __put_user()
> > or unsafe_*(). user_access_begin() no longer needs its own check.
> >
> > What's still not covered: x86's get_user()/put_user(), which do their
> > own range check in asm, a few architecture-specific paths that call
> > __access_ok() directly (e.g. on alpha and sparc32), and arch code that
> > calls __get_user()/__put_user() without access_ok(), mostly trap
> > handlers for user-mode faults. Probably best tackled later.
>
> ok
>
> >> There are probably few enough of these that we could address them
> >> by either adding current->mm checks or converting them to use
> >> the full versions instead where that is an obvious change like
> >> that usb gadget driver.
> >
> > Sounds good. I'll send a separate series converting the obvious ones,
> > starting with the usb gadget driver. I think that will be useful.
> > Let's see how far I can get; hopefully I can drop
> > __copy_{from,to}_user() completely.
>
> Ok, perfect!

Thanks, Arnd! FWIW, there have been no syzkaller issues so far with
this WIP v2. :)
