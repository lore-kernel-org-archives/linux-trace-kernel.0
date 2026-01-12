Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F097358D09;
	Mon, 12 Jan 2026 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224197; cv=none; b=BWxwTTulEXCawtwGWFAbnnprVwks4+C0npgGVeCG9Q2ear/zVB/3Q/mmU3DxOzVS+0MyO1GwnxhKLf9DXJFowxwNaFvJA6to94eREYJk5roSr77P+zoLoRh2unkgwGxbb9tJXW774ZgOYg1Y2Q7oJbOn1BTG+af3YrCHK+c6K5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224197; c=relaxed/simple;
	bh=+qtEBoYbCBcUz2Lo/1IEvx6RpEjyWM5yuchSJzfeU6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWpTHD9gv4/fiuqxfRgaGluTDYS/ESRXyPUsSCTK9266OGzynWyOVuQDIFaYgWBWnHnd2EsW3z4P6ZMdxJckftNivhwLgezBoeowNmywqt+zAtDdWA7zO3khlVuJBJncm0Jb94rTjp7K8a3eY1TkMDVwix4Yr2OBRXLJWa+ZUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f0nEfXAR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f0nEfXAR"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04D5540E0268;
	Mon, 12 Jan 2026 13:23:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yjFRVYEpdAKX; Mon, 12 Jan 2026 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768224186; bh=UqfCjtUHTnkTwZwYSVVnE3ioksfVqtUmKz1zLfW+ggk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0nEfXARFiTG84aq/XRV3His9qiHJARMVGajsrTbj9f/S4xO0i8/aU8QB2KTjbfzk
	 PADfq+lo80r8XNvwVsLDh5Kru2bpoTMUTUhidMb4hfm+I2t6r/+LElt25VCAfP2e1G
	 emE0Sa2Ry8ITbFp7CPw43MfGhAFOxu0ypLMq1o+80xGUbeu+4CoO+BDnJLnatq/f2/
	 edg40C+eVGfXaLAadZtl5gqGUrG7PwKhTY0H31Bbqnq5XmqspMqpSrWXYdHIWxc/Vj
	 qF67ZM2p12zNGMvoVeR9j66vmOQMZTZ+k425Lw8+a6SA4gruwm4T3lu2FRUwj21oiJ
	 mdnaLQfmLFZulhIeDYRKFH1hiYH2T8WFu1L3ytrMGEtJ0ovNPWjRNrkWy5vgV23eCj
	 bWGY/LRLyiNneOdtfhYLJeB+DNoQ78SoFwkYZveM13BR/+3n6KhVPVNWYiDwyxxGPV
	 VmERbHrprEs87KGA8pa16nGbwulmsmLUG/lfxKPiosIUhNer2+Amcng/FEeGL0OJGA
	 WTR8gdvbAn3PN6camG4R3LymOEet3QSzgKmgriF3TSgLv04CoiNa41XrU7fkOdCivP
	 MRWtUOahBmbXVsqzi6LGAsSpGFtEckB2jM6Y63tsCXTGzfxYLvc8NO15ZWsfqqRSEt
	 mxVNQBtaNYsy6FUdWz75cj/s=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3C17540E00DE;
	Mon, 12 Jan 2026 13:22:44 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:22:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: aliceryhl@google.com, akpm@linux-foundation.org, brauner@kernel.org,
	cyphar@cyphar.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	jack@suse.cz, kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, luto@kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
	tglx@kernel.org, vmalik@redhat.com, wangfushuai@baidu.com,
	x86@kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
Message-ID: <20260112132238.GDaWT1ntPxY8VD1hlH@fat_crate.local>
References: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
 <20260112122236.22214-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112122236.22214-1-fushuai.wang@linux.dev>

On Mon, Jan 12, 2026 at 08:22:36PM +0800, Fushuai Wang wrote:
> > strncpy_from_user() succeeds even if userspace data does not contain a
> > nul. Then it reads length bytes.
> 
> Yes, but if there is no NUL byte in the user buf, whether you use
> strncpy_from_user() or copy_from_user(), you need to manually add
> a '\0' in the kernel buf to ensure it is properly NUL-terminated.

This looks like a bunch of churn to save a "= \0" line.

The more important question, IMO, would be whether there are cases in the
kernel which *miss* a NUL termination, audit them and fix them.

That'll give you a better idea whether such a *_nul() helper is even needed.

Because converting only a handful of obvious places in the face of thousands
of copy_from_user() invocations in the kernel is not doing anything useful.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
