Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D53750D7
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753781; cv=none; b=r9nl0Uakvmv5kWD5JLdFFc3q87Law4UNSJW1uh3zlh0aIOjDA0XurRQVdOkHMp63E9s8mwpeklab32+TY6q3YXERvJI0Fu7SX6gUCxr3Jh8JgbmIjA71Jgaghzp1giTdRFK4y5AMjnhmWuJcsg3XqeokzMlnPGksfhzP3WNWtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753781; c=relaxed/simple;
	bh=2f37lwrq/vfbI/Atd508xfmlAOAAdf/kzSySoRuzvG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWgUrgUZxC5xQ4Np8cLSi8fLD4RuPaiYUrQyDr3F78zDu3lvDkrlR8RFFSwIU8an19MqnB8Z+9NSF5iImFabB5rG+nenBxkmfaetS0QWNoYH0xmusLW23eXnrMhtWXxZLH89aiwnbzgFUaOU1/m028ARr+qbxdgK3PZSiAkjN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+8OVroh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+8OVroh"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2004308f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785753776; x=1786358576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JRwLB4+6t3H4PDGX6S9Qf/LBF8/KecqQ9VavQZhHs7c=;
        b=p+8OVrohDyfUWmFU++b0OX0oe/PnFqdm2kSIaJp7jTViQnVfeqrFn/Qg1+atTOfEjY
         gV6D/JwZuWcCUOwfz4NnaY0QRTKTb+yx8D6DoF77HszUEyMsA8h1okzzaD1qaob1PZl9
         5MFZlUNj6PpPQgOtXvksUgYk06z42UgDcPosvf7DcP+B9I3PsPmUYjQAqrqnZGT2Hk2r
         /27Pcq5b3dRbGEnBpK76a3kw0zhYmGFrxifEPvUERydSK/OBxKSu82WnG7DVpXLcWVnC
         kIEEjeh/d+4nL7Qs8qF0qOAlgcyA8qV1cj3sOUSjPKBbMMEU0DVi8mzAALER6dFHQZ9a
         yxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753776; x=1786358576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRwLB4+6t3H4PDGX6S9Qf/LBF8/KecqQ9VavQZhHs7c=;
        b=NshjoEO7nS8x4cDektBglcnoU3JyowXmN7P0jmbsERtXcn6YRPfiIUf3k/tnHfrPM0
         pRkf4ov0zO6bElQobx95ALoF2oXqGQhaR16mOkPLdDeOvUvJmsEXlPGZ7EGBpDgk+wCf
         0S5Gyy284IRcMJoBSJvonE9LlxAhUK5MLXgDN5PZNib7uleCYCWYWAia/2KP1PRE4rZh
         aHgkUt94AqAVw7XGWsrJhU878t2KO+7vJqZOulJxJ2pBDjBrPFiOco2x+IuG1wboy6my
         uLVtMOoC1Bh3EzGxdVS54vN0EVwbegE9jJuu86DK9hYh/TcVptHGQgV7CQjdefx7F1EG
         FYTg==
X-Forwarded-Encrypted: i=1; AHgh+RqSfR4fIRurI9C7WFXdugEhp9fkRC3UdGw0CS/2UNXx4tDC/BO/584QYcOZEpGPcn/AQV2P0ZNatLBhgnscRzLQvZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzronRgiBRqISQ1nhF84Jxp8cB3Gisn6/7yNKVnHj89k0HPdMtp
	bN8wBX4JMHz38+7E2hDawzq1b84baVqhbLb1W9srz7OXjWu4s2MzXa9MN3EJyTiSUQ==
X-Gm-Gg: AR+sD119CZAM1j11Fe1Q/GvofoZCHzJZ6AfG21h5esAFjI5Mr7Itz788Y5OdAtBxKQO
	G7w2h7+pA3cHbO/OdB9m4d28lve0nid+/8vL7rXmU9R+jY7ULEQIeqxz95q7bWD6NEizbfOdxTH
	5e6VnZP0Aq6oncT36CdmQbo8vxYsi7yp243ONQC29WYesyEGBUQw/2yh5Wi5qLt5hUEi9XiPpxN
	7IhvKHwsr8ehmGoF7OKu3QaFuj49iS2FSdi6Gk73KCrj4lZmkr/tQR+mpK6Ih26hN33bdE0Pyis
	JqHT76jJ7NQIEAs+Ve9YLqsrNp1+AN+XhBcTRK9aZvaEwjXOWPnKTjlG5VCXch+DxDa16HG4i2/
	In5TtlBBEdPKnn1wS4NgJAQ6/8kdt4SEC2yKyYB2FJSK+D60pWMlwfCadez/1gk+qcVt6Y5+i3l
	QSUOwuFxUJDEHncv4JiQ/cFaqgjSdX00gHmFJ/4KkAcqYwGieP8OX+8cLH+3mM0b/+1axSvz7u7
	Hrau+oddRr6F0IzFgbl6oE7ezd6jO22OsQprvPaSfrGSbWV3bFQhBQ=
X-Received: by 2002:a5d:6586:0:b0:47f:5b52:5579 with SMTP id ffacd0b85a97d-47fd72d4a27mr17326994f8f.18.1785753775925;
        Mon, 03 Aug 2026 03:42:55 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm32978771f8f.11.2026.08.03.03.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:42:55 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:42:52 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: maz@kernel.org, oupton@kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, alexandru.elisei@arm.com,
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, qperret@google.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	tabba@google.com
Subject: Re: [PATCH v1 05/11] KVM: arm64: nVHE: Run the source checker under
 C=2
Message-ID: <anBwrPIILsaYWK_K@google.com>
References: <20260720161343.1367007-1-fuad.tabba@linux.dev>
 <20260720161343.1367007-6-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720161343.1367007-6-fuad.tabba@linux.dev>

On Mon, Jul 20, 2026 at 05:13:37PM +0100, Fuad Tabba wrote:
> The custom %.nvhe.o rule reuses rule_cc_o_c, which hooks the source
> checker only for C=1, and that only when the object is rebuilt. The
> C=2 hook, cmd_force_checksrc, hangs off the standard %.o rule that
> nVHE objects do not use, so "make C=2" silently skips every nVHE
> source file. Call cmd_force_checksrc after the compile rule, as the
> standard rule does.
> 
> Fixes: 7621712918ad4 ("KVM: arm64: Add build rules for separate VHE/nVHE object files")
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Nice, I have wanted to fix this annoying issue for a while now!

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index f57450ebcb498..ccc1fe8394094 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -49,6 +49,7 @@ targets += $(hyp-obj) kvm_nvhe.tmp.o kvm_nvhe.rel.o hyp.lds hyp-reloc.S hyp-relo
>  #    avoids file name clashes for files shared with VHE.
>  $(obj)/%.nvhe.o: $(src)/%.c FORCE
>  	$(call if_changed_rule,cc_o_c)
> +	$(call cmd,force_checksrc)
>  $(obj)/%.nvhe.o: $(src)/%.S FORCE
>  	$(call if_changed_rule,as_o_S)
>  
> -- 
> 2.39.5
> 

-- 
Vincent
