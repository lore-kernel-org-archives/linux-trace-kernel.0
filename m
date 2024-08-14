Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E31AC44E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637388; cv=none; b=HS/wR74ScqbsFbD+p+Ya+rNpx6FkRNbFo66WCP+BEP1GS9S1LkeO1Vu4KBnrbmHmb9HtK2qMOYO2RI0PcSoiuQCe0gIBt+JdFGC/D+fs/9jerGfbagmeZA5MnDDpm5Wqc0sXdLraEDDmCrHlBSzkRSDtrau7kNQb3IMuTEWUYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637388; c=relaxed/simple;
	bh=tn4995DAyVsJ3De0XVz7+XmF9zO0iObunLUXxBhv6F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG6iqKtpGojyesyRvHmc15aCdYBIEp8OKy8/+0CgpDu1/4ztD1jM9qGBqNUz7ccQdjCGoRi5g/oHb7akAbLqCLbuFtdx9JZ8N60kkeldh9adFuN745yoFSL58KApKiWQXhvjulnjwRrQfwaZvHK55nVDyVr+39RX4Pe7J2n4kMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CSW5WiCU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CSW5WiCU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7de4364ca8so688553666b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723637385; x=1724242185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8+OgZPrbcfevzxKpS5z7cjOxcrGutO4dpVagSt8VMo=;
        b=CSW5WiCUYPohFVsyMc3HNlRN7wjSwqp/gKFHAoBKDA8RIl/OzVVucDZhv/U7SZwt6p
         kWQ+x8wk5Me8NxAm9pWci1aE3FTmoElnmMEa6Wbnu3Dc4ov+bTLlAfZTcrsg7oTXT6sD
         QFkaYZDqBoJaD06ANS10A/d1SXkaMMYYz/7Fb7kHJdWt7tku7+HmArKidmQok6owf3X6
         /SQFVvYYIK0BAuMutDVDzKWLQ1GtxKOwaBN+e60fqPDYBHnnm3+Xj7l7mBQ2P0DfmJ1Z
         yZRb1b9WjY9Hh/pL8pgO2dPOiFDqzNNvvb6Yoc2fFGWS2eYHKNBQd2R0GTGX3LLTUMzq
         sfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637385; x=1724242185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8+OgZPrbcfevzxKpS5z7cjOxcrGutO4dpVagSt8VMo=;
        b=V8IfGhzwyWBVDNJnXyzcCV9zAMqJ856RibXQLN7D1u+7f04nwOGEU6CX08tmfqojhA
         Ln7fsk3peexHagMDXt1YYkaHMBMw2Sel9gNaS4Vo6Q6ma8njQn0Cqnm5cXqNsZhtLVc6
         2MitDfegA/IYmivkvJf0jbCYMMxoY7S8dofsA8Eel3DZIqowY2SzkYyD/0KOJd01sOZl
         G25xp0mvCC7B0TAA3+didKi3HgkypEPqnzPFe6TcxZi0+EOrwSEoWhl+oKPMLW9AJQI4
         VlV4rIjXl7jFSeH2HXHZ5ouQsXOSKILDQwweW8arzawyWmXgFQHQFRdP2ywWGvYKIO3b
         DbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUBiQIWgfquuHM4tZcyGPqwDuTF6w/4FjoHQ3QfW2VES2Npwuy0QjKQNrvy5CKkyGnl0H0c+v5n5Pb0eUPJCVhKuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xheYP3ygROpaDTh3boCdk8GBG8hLzxD2l0mnMqrZh3awOOHI
	7qj4ndAImt8mVdY7XHCWNfA3aMwfdu/EqRiRmpccypFX1lUBh5lEdE2WpbpnG1Y=
X-Google-Smtp-Source: AGHT+IF/AQc5OsMsDO36uU4URAWXHfYH7FJV3YMENI/3lH9Cf+i/PLRvceCxirD4CDWV6m/Rt52jZQ==
X-Received: by 2002:a17:907:efe2:b0:a77:dcda:1fe1 with SMTP id a640c23a62f3a-a8366c32199mr159835466b.25.1723637385039;
        Wed, 14 Aug 2024 05:09:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa69c3sm165813266b.55.2024.08.14.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:09:44 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:09:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	nathan@kernel.org, morbo@google.com, justinstitt@google.com,
	mcgrof@kernel.org, thunder.leizhen@huawei.com, kees@kernel.org,
	kernel-team@meta.com, mmaurer@google.com, samitolvanen@google.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/2] Fix kallsyms with CONFIG_LTO_CLANG
Message-ID: <ZryehvKuUogvtYhW@pathway.suse.cz>
References: <20240807220513.3100483-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807220513.3100483-1-song@kernel.org>

On Wed 2024-08-07 15:05:11, Song Liu wrote:
> With CONFIG_LTO_CLANG, the compiler/linker adds .llvm.<hash> suffix to
> local symbols to avoid duplications. Existing scripts/kallsyms sorts
> symbols without .llvm.<hash> suffix. However, this causes quite some
> issues later on. Some users of kallsyms, such as livepatch, have to match
> symbols exactly.
> 
> Address this by sorting full symbols at build time, and let kallsyms
> lookup APIs to match the symbols exactly.

The changes look good from the livepatching POV. For both patches,
feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

I made a quick glance over the code changes. They look sane. But I did
not check them deep enough to provide a valuable Reviewed-by ;-)

Best Regards,
Petr
