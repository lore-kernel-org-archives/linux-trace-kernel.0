Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AE1E571A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962529; cv=none; b=XGgSySHe24QrZ64gmAnXj+fO581y+eN4gzMxKk1rNFQew6pYvwcqnmJDHO4SJZfTxYcak7bcN11WmdtrRUmThAumj0oZc4Lsw2e65DGQeDx32RJpur0aMSxtOnOiBo/Pc00CTQVl7D9pnRQI4mRQTVCaH1Tus5XKH6Xc40Gvz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962529; c=relaxed/simple;
	bh=UkJuL8+zmGtSoHuxf0o8yRBe8ZiUwlbXINtsp7R8Cnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0aDGL7fZ+ZxBE6j9enhdsCTcFvgN9+GjOhrDp4cj+UHIbu8DE2enAQ6Qn2s0/olU6X5ePJKzJpvrJ9dgSAoUqo5++/+vRiG54c1pUXIiPzX4MqgX3eAg7a6eYbb/2Et896DJ3FZHZGgLNMAvhlq3wi6v4CggPaSMd8J4kRcHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpV7UiDO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpV7UiDO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea5252f0a9so131340a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731962527; x=1732567327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Xdj7KiBLCPRzY3Todf2snUR+C3yfhMagkENx1A3bE=;
        b=VpV7UiDOD3tc9+CVDlSlO6CzByVPi/v/U6eXH5ORIODRcc3W0xh+N5LpcK9+z/CPfN
         hRBzg6qKX3VS7vI6zOgFXopIqrNlGtCO8GAMod8+yfRpZ84IKYkdtMcIKd6tTaJj8zy3
         1zmfp/5BIgy9SCXf0Svx/u/yNpUyvVUUXr19H944Dvja4MUJ7yszgtneSYfwVeionzzm
         eQ/7J+JfgJLGffmdD+NekIKWv9tnzUlFljRFFBZHYjqg+7BroJG35L/811qy34mQe/+W
         PBXglKe1ZSbLCma3BjWMyNSCRDqCgvsndLTYR/Tn4HcESyvl0hqWF+2SaAaG05QRhhvp
         3KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962527; x=1732567327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+Xdj7KiBLCPRzY3Todf2snUR+C3yfhMagkENx1A3bE=;
        b=mYTy5qiIMwrVQ1yxu4i0/0UZJ5NwHV8Smly9SFocQetvNhccaS/PgLdgKFGLJP6u+n
         z1KnUe7YjcduUqCWNLrcJbH6oVWriGC1WPxkvVzawS8uTotySKxm/JxPxrv+bBjpRBov
         RKOEAx2NRVoL5Gw7sQoArDd9Tc9QXmvXo25SO53777kZITzsw1eAyT5jUxV/NXul/sRt
         WfCHeZSPYwhRRwKfF8dKX75xoNGPpquP/firxpruz+OJUjM+WZFu4JItRg1EYfSKgW1v
         8akKJloZhJtXgRGcNZ6rcx6iv2L3myImc18n09bS+zQeER9Ro0+CsqSWDUyybasxdkJK
         6s3w==
X-Forwarded-Encrypted: i=1; AJvYcCU8SkgJlBdHbvkATJg6HQGQSnnQfzMTpVsi636OXJS0Ybr5tsfLnhoFJxMWrC3yqfxs8RCoRxyIM5fiIBnX3rKSIg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSio1qlW2faDL+MfnLrLIGZh2R9l+javCLaDx2LuQ+o6pXb0E
	BKrBemT+w1vRfdcVO/bqhQ+GnuTcARRa1sPk7f2haiVfc6ruYpYSEqBL2eEbgJOtnpocbWC+qkn
	Uu6hxgYhGVNEUfuRiGIUq+foKGdtdrE7AqGM=
X-Google-Smtp-Source: AGHT+IGxkBt0lYQ/pb92GnoB4p2dqZtFYBy874Hafj/esamMytu1A0yojsAYvUjvM/AphNdqGi/7a7NpBFxY/qLiFfc=
X-Received: by 2002:a17:90b:1e10:b0:2ea:5c01:c1a0 with SMTP id
 98e67ed59e1d1-2ea5c01c415mr3170816a91.3.1731962527424; Mon, 18 Nov 2024
 12:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411181440.qEdcuyh6-lkp@intel.com> <20241118202727.73646-1-aliceryhl@google.com>
In-Reply-To: <20241118202727.73646-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 21:41:53 +0100
Message-ID: <CANiq72kd31HsDTPNBnLrRC+mkGE-u3qTiPWuQ08TXFcr-M7k9g@mail.gmail.com>
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to `static_key_count`
To: Alice Ryhl <aliceryhl@google.com>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, ojeda@kernel.org, rostedt@goodmis.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 9:27=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> When building the rust_print sample with CONFIG_JUMP_LABEL=3Dn, the Rust
> static key support falls back to using static_key_count. This function
> accepts a mutable pointer to the `struct static_key`, but the Rust
> abstractions are incorrectly passing a const pointer.
>
> This means that builds using CONFIG_JUMP_LABEL=3Dn and SAMPLE_RUST_PRINT=
=3Dy
> fail with the following error message:
>
>         error[E0308]: mismatched types
>           --> <root>/samples/rust/rust_print_main.rs:87:5
>            |
>         87 | /     kernel::declare_trace! {
>         88 | |         /// # Safety
>         89 | |         ///
>         90 | |         /// Always safe to call.
>         91 | |         unsafe fn rust_sample_loaded(magic: c_int);
>         92 | |     }
>            | |     ^
>            | |     |
>            | |_____types differ in mutability
>            |       arguments to this function are incorrect
>            |
>            =3D note: expected raw pointer `*mut kernel::bindings::static_=
key`
>                       found raw pointer `*const kernel::bindings::static_=
key`
>         note: function defined here
>           --> <root>/rust/bindings/bindings_helpers_generated.rs:33:12
>            |
>         33 |     pub fn static_key_count(key: *mut static_key) -> c_int;
>            |            ^^^^^^^^^^^^^^^^
>
> To fix this, insert a pointer cast so that the pointer is mutable.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411181440.qEdcuyh6-lkp@i=
ntel.com/
> Fixes: 169484ab6677 ("rust: add arch_static_branch")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Yeah, the original had the `.cast_mut()`.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
