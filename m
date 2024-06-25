Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C41448D9;
	Tue, 25 Jun 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339090; cv=none; b=N3Eo+0hUWiFmV4RCu1xrZO2GjdcNfk0+ZHAH/jDXTgvUhb+idfbv3RmOKPCNB9zLgJmfFQU63C3P0V1KCpsUG9OQXZXt55AaCgsovv0S89IV7GcuY5IOfTcEOs93EoefoENyBCOS55s34ScKxNsm/YJisxKR6MmGpp1utKbd9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339090; c=relaxed/simple;
	bh=47HQqh62bnsTizgbR20A+Vzh1+D6CR3M79ZW5+4A4pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpgqVNszMoLbBwM0FprmbwLAthScz27PJeYwVNNwjHvlY1lBGL1Zt13PBRn4HcyPpajwA0klbJHqVlJnPT2c8Tt+TvAiofaNnDZxZw1xpY3nG+C2jTIRBiIp9X51Miitkmw4E3avLJK6egBzOkIJ4lA9RDQTu54mNHbPhJerGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V83S62df; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V83S62df"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-444c5877b1bso18406221cf.3;
        Tue, 25 Jun 2024 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719339087; x=1719943887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7enU7EQn35wapqSJ3Ru7OFtTxxJNvvUnWFzW1y1Qj58=;
        b=V83S62dfptb8KZcysg5mMwKc63y17muFQQdwhXnGp5VBVBoT/Xf6AzrXDHrvqOuTkQ
         8JbzGPDwz8xuxxjW5f28PUGz2oOM4s+rBZp+NcyDXx/fdI51s7/PTgKnvBdOf7zjcpkS
         MxGsksJNLEj7E3DrOei9CxKQbzl8yNXFv+Rg4Va/OjQb3HqHxXa8jT/0URK5cym5vyUr
         cqzRCf0ITMmgyMrFknT1CShGH6LsDIFgGf2QgGnroD/QcQOm4VvB8TVbYOwkpWFjNDu7
         8Lry0AmlcliQGhq9f/twY7qITew4ILwmwsw7/GrawPjVRoKcLD3FWxpdREjOTg23rwxg
         Y/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339087; x=1719943887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7enU7EQn35wapqSJ3Ru7OFtTxxJNvvUnWFzW1y1Qj58=;
        b=cFCltKeAODro3fUQKiAYPYP3icAEjSUdSDjeIhKVFcfaagDLG0NVShdk/JJ2RQbQDg
         NQVIELlg/4tdWdpArh9lm5GG1Tj1OK22gKPemI9jS+Dk7QQY55kYclT/ePcAHLUiXdgA
         SSCE5VgZaOEE9tbatyOU/xmltD63VJ8oPE9ia96WqDMeuJWL6Fms0OIU0cGzFchshZGA
         eNBzlhyTI+kima9mRmxkwEB9RlkFKJqUS7Bl6298GOhb6ijwFL/j5RWZRS4SyhTN2mm7
         U5AyFg+BIMytpXKqcme1HoyHXDNV5FXoEg7qa37UlYebW1qIb7yR/LIK49UYFnFRW+HH
         gcIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQwKlntNwU0W6VeGDuJlUeiG48kXZ/1EAsOR+JbY2SfzqToGDjgSshq7OZM1OvRI+jP6vfobw9Ef5aSsp6RDQjAe1JPULeHjwcbcE2VtLevOHpWGGUoUeGSppX+K2zQjmgea2OP71sfcNHYHk4G3fHHSa2su+s5ZY0VVpuUC9M9TNh0U+EIk4AKYSqqfzLV40=
X-Gm-Message-State: AOJu0YwGYKuErZrkLoG0gExeB7aGtZMRhVm7VSmn+wOkeBtd9HVP0Ucg
	uqmx7DkJeDuBH+3jGxJuco1U09Uz8e5IS1vprePyORlHTCf6e5xu
X-Google-Smtp-Source: AGHT+IFfA8lsn/fqFUDCllaQaIvkwzaaRWNT9WgCxsf+hTzitqmVpVmjg7wnBdgeo+CnODhOumFdUA==
X-Received: by 2002:a05:622a:387:b0:444:e526:8ece with SMTP id d75a77b69052e-444e526a6afmr57498971cf.19.1719339087524;
        Tue, 25 Jun 2024 11:11:27 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b989aasm57828431cf.49.2024.06.25.11.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:11:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C806E120007C;
	Tue, 25 Jun 2024 14:11:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Jun 2024 14:11:24 -0400
X-ME-Sender: <xms:TAh7ZlqXogQ4zA3jMFJuwGmE3Sa1IWefy7OxBsxlUMSSiW50qUS0iw>
    <xme:TAh7ZnppI-hYcH1KZXxHqu0NgdSlKmx0OhWWzOaYAiuforJqfsNCxe2YrUOPewCTL
    GDSUMcKamYeieVWeg>
X-ME-Received: <xmr:TAh7ZiPdr6eNxF4Y9_I-LQBOhBerSRXUpqLywdxaR4P0tG6_V6ctFekSi-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TAh7Zg4GtuEk00-uYZSDR2907PfGVMiYiQM859mZyr62zPtd3kXSog>
    <xmx:TAh7Zk7sHJkfOXLV3qWoiuV5QMjrvwewRR1nB2Y7Hrj1cz9B25AS7g>
    <xmx:TAh7ZohNbSpHtE15kC9_9nxH2-TqMW_yA3iJZVyaiiN-a_IABTPbog>
    <xmx:TAh7Zm7ELyC6IorsvlJ1sxG73XSeYqTE8LcnoHTrndJjpSbnSCzs2g>
    <xmx:TAh7ZrJD6iBhZgMEHFh4AsEvw7ELP_NaAmxpZNufZS59jU_Hve34ojRP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 14:11:24 -0400 (EDT)
Date: Tue, 25 Jun 2024 11:10:47 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add tracepoint support
Message-ID: <ZnsIJ6ejNX_dAc8f@boqun-archlinux>
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
 <20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
 <CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>

On Fri, Jun 21, 2024 at 02:52:10PM +0200, Alice Ryhl wrote:
[...]
> 
> Hmm, I tried using the support where I have both events and hooks:
> 
> #define CREATE_TRACE_POINTS
> #define CREATE_RUST_TRACE_POINTS
> #include <trace/hooks/rust_binder.h>
> #include <trace/events/rust_binder.h>
> 
> But it's not really working. Initially I thought that it's because I
> need to undef DEFINE_RUST_DO_TRACE at the end of this file, but even
> when I added that, I still get this error:
> 
>     error: redefinition of 'str__rust_binder__trace_system_name'
> 
> Is the Rust support missing something, or is the answer just that you
> can't have two files of the same name like this? Or am I doing
> something else wrong?
> 

Because your hooks/rust_binder.h and events/rust_binder.h use the same
TRACE_SYSTEM name? Could you try something like:

	#define TRACE_SYSTEM rust_binder_hook

in your hooks/rust_binder.h?

Regards,
Boqun

> Alice
