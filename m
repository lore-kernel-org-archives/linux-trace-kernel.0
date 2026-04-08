Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCECA3D47D9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661897; cv=none; b=VPI6GRa53dM1yDhOyn2ewWd1mYmi2Mp80Cr4pyVEzrTA7/wyseJUkUmn2QOtrXOWBzGGXenfbE5H5Nli+E4PIfBvdeOjUDC/Db45MCZ9B29ZgHf5DnZlQem8qsh7tm0lkLQTAjAuLT7wxGqdceH1v0yfLqaeP9oVuiv0HVsCP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661897; c=relaxed/simple;
	bh=Xvx5NbnOpNGEloDoPzkjBb0luYYTDDyuKVmozJ9v8uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwgM/wORMCcNa1k+Gi3mcwqrqiY/RI742ZNVdbCbLLNfcc4cdex17SDzaQx/q53nQNRD5UwMRovju6uyKeD1CYxE792e5nFlpanJAFgFpePyaRsrvuRguDmAymG+Ge9MYPOj2dgXEfVGt4eaCsGKo0cnu/WaqBvI2yvA7CKu7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IvuKMKQ9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IvuKMKQ9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ba840146so23225345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775661894; x=1776266694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laiXp2rBEiPl8a2Z73ajRETlDqB8PAbCI44ILQPyqZU=;
        b=IvuKMKQ9jtZ/dVP06vkY7CTiZM4OuHmVnp8SRil2wsw+5I0ykRWCnGsExOFOYPKIZg
         U6Ymn0/O77U8r+O+X+q0jabDGdfKvl4xj/EVc6AbKwQCSaWk7TWUeaiWfTalUFOZIYwj
         UPJFmGWJvvQm1KCG/J4smh5BcB6Glm8/m6U7SDcCyZtDb2okWxp0w60hXrLmar/TF+uG
         MekJaoDfdS/tOTqmOE8U+XkxteSIrZUp/94aBnnQvTa+1ktb38KpLj5hY7MeUbXy0zdj
         /RUTGXZgXYhP2IYM0fqk90rFWks8YnbcCt0VLrYVoKTIjbP0yFZlQ6Zl6euxmwuC8P9O
         TdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661894; x=1776266694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laiXp2rBEiPl8a2Z73ajRETlDqB8PAbCI44ILQPyqZU=;
        b=gifGXJ90qZKXy0QjMAQseCO4uB/wwTiphWwVSt/8yxxbTyI30sNcYGKL4iiDKR+fr3
         q6kx/Pgm9a0zfi9cTePRRuFiyoa9Ek/ykzLZP+gxJMeQ+WKmbGIvx2SpCk6iiabpJW4c
         pw22a+5TtGBiwTXyCJeMq9u5sAM36SW97XVOXWdkin0z5yIV4MERjFRpdH+Kf9B56J0N
         oPuBcaJIaS2476zLGdaJ1+8JexfLCshsR8INMV2ryrxQ0f3Nmh8K/89uI3sc0G5RFBbL
         GUeolp27S4WWfJkVupF9osqqaZwNCsqyj/R63dj+7i1imypJhGq/kER1/Hdh6epx7Jj0
         Rrkg==
X-Forwarded-Encrypted: i=1; AJvYcCWcgBWXXyP1sxGgC5ZdX2Uw1j8HWL/LF1vMDZnHMjY9mmCR3dmBsbQggjnJTwE2IBsYpX8byXjrCM2JthoSFNnK3wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWln3nLIqHSVSdPZSjCDaVEp789AH8ySNzmWwDFb8JD5rPcxCg
	CeGo+A1wzPq63bjFpmxifB+R4OTTIXxcLCTPnOl1C8cN3gJgoW/n13mnBXS6wHw7zeg=
X-Gm-Gg: AeBDieu4wu9Y4qsI45aFjSkmjPELG3tWaBat4aBtClxxrZK7PyU4uF8Pyn2XOqGffvb
	YG4hEd6K0claxXqY4Jdk4Z1gODOvVli1HKe76R2XsLJt7j9hlSx8l7iqox3e5NBOLTfDoLhiIM9
	6Oki5FQdwBAoenfoQj+zdDblRqQJ3gaSPbRJbajs0yEKYw0g5JgRn6mZPo9XdSMiNJgecw/G4aT
	z9xl2zYfsw/n07tvujAJd8wTPu8wQ1oaI6EbXU/jg+JDr+q30k0deLFZqZQItJsE2SvoT9RZcYg
	4U1TgQl5g+ZcpNM0qPniGbb+wGBPb8oJmMYx4qyeHTDXddbEIsPTXD+5qAU48aOlx2ylOO3HCkK
	Z1okx/HHqcgPi5//VtBXvsY3I5DT4T31I/9RM4mWj+Jz2pjWOkgiRBrB8ZxTfhNUH2xp3egpCvj
	iR8N++FBN1Sk8fEh1Q6OUtW+LZRIatTFn7qbnwpPAEteM+
X-Received: by 2002:a05:600c:6208:b0:488:aa3d:fab1 with SMTP id 5b1f17b1804b1-488ccfc0554mr2091505e9.17.1775661894090;
        Wed, 08 Apr 2026 08:24:54 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1bb778sm32985e9.7.2026.04.08.08.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:24:53 -0700 (PDT)
Message-ID: <999772c1-ec48-407a-a0fe-64665620d855@suse.com>
Date: Wed, 8 Apr 2026 17:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] module/kallsyms: fix nextval for data symbol
 lookup
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>
References: <20260327110005.16499-1-stf_xl@wp.pl>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260327110005.16499-1-stf_xl@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 12:00 PM, Stanislaw Gruszka wrote:
> The symbol lookup code assumes the queried address resides in either
> MOD_TEXT or MOD_INIT_TEXT. This breaks for addresses in other module
> memory regions (e.g. rodata or data), resulting in incorrect upper
> bounds and wrong symbol size.
> 
> Select the module memory region the address belongs to instead of
> hardcoding text sections. Also initialize the lower bound to the start
> of that region, as searching from address 0 is unnecessary.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

As a side note, I wonder if manually determining symbol sizes this way
is the best approach for modules, instead of simply returning the
st_size of the symbol. The logic comes from the original implementation
in "[PATCH] kallsyms for new modules" [1]. Unfortunately, the
description doesn't explain this aspect but considering that the patch
rewrote both the main and module kallsyms code, I expect it was done
this way for consistency between vmlinux and modules.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=d069cf94ca296b7fb4c7e362e8f27e2c8aca70f1

-- 
Thanks,
Petr
