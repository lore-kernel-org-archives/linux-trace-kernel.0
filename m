Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6D1F153A;
	Wed, 23 Apr 2025 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369607; cv=none; b=A4LtTam8w26x4O90bUJfqAWfBV0/cqHiGAwZ9/vxl7ZYuKT9PkL834vJxLDEGTLXHmpLGYQp5qxbyQ0HTxpMRoru90nCbzjo1wgglsmyf6ulru/IIvD6qC3r3WKlYsuuxoG1HX2Ss/09fpVO0uhgDAxCwZd6tj00vWD3MIwc198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369607; c=relaxed/simple;
	bh=vEGRcZwU6uei83h+2nEL0bS/T3AeOHiIWgX5B9iygzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQRh/W2hp6sUj04mhhbHlo2+4M6trgPG3W4pZuYAkUQpJlYhSiWVfD2VjUBAhmD9/JkAJ57J3sgefg8hR16plJyct0ASLRTqUMrz1wW+Xc4jw33lIDMyNnOY0LOEjee5ukxZY35dcgtDaoy1kaYRQgYfnOMTrSqekGmXvSsSRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPxfjcbW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPxfjcbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76F9C4CEE9;
	Wed, 23 Apr 2025 00:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745369607;
	bh=vEGRcZwU6uei83h+2nEL0bS/T3AeOHiIWgX5B9iygzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPxfjcbWk7PJWHQ7s/KGv1hsH9Mr3548gesh6wvRTR3wd+bdf1FgbmF8mhLlnZoe/
	 Sj7+m8UjXA4agembUdxP03iNF+EYDYMvNXvW/Rbft1C4bG2p5xmXsNEys/Xv+G5a+J
	 cxTXavSzuaBUrI39MJTMF7hVGK2dYKsHU8HWXD0mnD7JDLt0np57GyOaoVGV4CE+9Z
	 DsVJdb2Ey9nM3+46+sJ8FYP8vMHhQtBdjJWrVANSydvU2/2rzbIISd7P4t3oZVqy5X
	 fZkfv1p0gaoiqic/EIPvTbbOodutqpxeSZ4O7hy8pT9/bBoHyyPqdBE6tJZtX0NBLB
	 aSjY/vrL1z3WQ==
Date: Tue, 22 Apr 2025 17:53:24 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 6/6] x86/vdso: Enable sframe generation in VDSO
Message-ID: <2dypxtkfs6wj2i6pjhabkn5aiwaorbg25gltlinu4voo2l767d@jpwxylis7xaq>
References: <20250422183439.895236512@goodmis.org>
 <20250422183722.919601983@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422183722.919601983@goodmis.org>

On Tue, Apr 22, 2025 at 02:34:45PM -0400, Steven Rostedt wrote:
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
>  $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
>  	$(call if_changed,vdso2c)
>  
> +ifeq ($(CONFIG_AS_SFRAME),y)
> +  SFRAME_CFLAGS := -Wa$(comma)-gsframe
> +endif
> +

Based on the discussion with Jens on v4, I think the $(comma) can just
be an actual comma here.

-- 
Josh
