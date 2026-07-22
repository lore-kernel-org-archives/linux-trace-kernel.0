Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED103D6CD7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754742; cv=none; b=uJTA+JnW9ekt97HBXWaM+1hiWzqsCvw+sXiIqTXFQYmQtSfQPXfGzcZhiWrcLyMSYqCc5wWQ7ysmWHTPay7pmLWW+SoD64gVg+Fk9F4MI8Uf55gKPuK7w5h8ob4w293XJWarBzXWOQKGaycqekpDUlPDVMhoNqLiIybAdSQkIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754742; c=relaxed/simple;
	bh=1v6byf3doib7lXScxa29tBKEg951i25yQTkCyjE1yPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEJYedpijB5m8IWLeUM/grWfV0Ca5RNbihkiWWlStl/bBlk3TR1ATaWpZyoYPua9fe0RL3z8mQ+Oo1pr+rikevfhrEk8DHHU9KxvhUfhCavSjnXzGjy1F5SBsmFbCuN7CTNDOG/rp7ePzPPM9IDaXgF+3++Sul2oEmqetGXW+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQuLZ68g; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQuLZ68g"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6688dfaed31so1635777d50.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754740; x=1785359540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2hAbTXYH7pOCgQd3BSSUl5pvihpdrNJ4HnSdNTSi5I=;
        b=kQuLZ68gyxWKJQ2gs/HgMp+PJit3Cr0HMKMogYgF5qHjH0nKQvjSAlqLEX4LvFy/AM
         MQ+L8xJmxIebXpPDA8rqHPtJxb8o3C27zYkxaF+I5DRxTVibotKKia6OB4zFjV5gaEQx
         zQTBb5VPnhwcFJmR6LG4MzgdFW6yaqLekmlJaqqigcwgvWWn63FX6HnLxxvyyPe3Yp4b
         tUyptGNNnWgyXuVtl0oOwmihcS4hv/3QPi0Lbkfyl5Mfq7hb9bkEvrN8ewJpd5a+He+8
         XAZpQHTiY0d+OmlaZT5Hm+21ae6If4I7Upt8wk4kK2VrbrPiXkMzvDMZ1J5qwymIk8YQ
         4CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754740; x=1785359540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P2hAbTXYH7pOCgQd3BSSUl5pvihpdrNJ4HnSdNTSi5I=;
        b=MbMlvRiLE2pu7lehGZqCo5H2ft/Mfpgby7cZuOf8ulc1iOgBD9OwXQPXYRMXOcbktF
         XSC/EYlVjAHu28/YrSwdJ4qGyn/HjhPPchbXMon0xtShqQXh/ntvwA3f8W5g7MHPicj2
         wRSXicQe+W/RDRmDD7B842A7ddnO7UsX6Oo4SYbDHH0l+cRoNl/V+z/V7mhCdz6lURte
         sVS9r9mR9aLZV1EOD9n9U2gLssqbwb6eeCnxCfB+h1zXktSarSi6lXpn6ePSxJvc2Br9
         tfeeyIYv4WVnuSjcdKdgROKgIQstPj6rs5/kIoBjQwV5pfq6IG0JcmHRE/AnxheiQqY0
         KBlA==
X-Forwarded-Encrypted: i=1; AHgh+RqSjDqDoPb7jmEa1lrH3+jIOUp/ImuEx8ebpyPjmuWyAoQSlQ5UBRQTbmgDWfzzF2605NVPFtE11RTcilqNOnDgZSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9w6JTEuGCPuiqKgBLRKUdKxgdqgNdctpo3IMsQZUrbiVyQqv
	n9IzknKAbFHJ+UN0Ek1r8UNZJ1u/CDwYnQjicspuS6oEY1cJkXjBzffQ
X-Gm-Gg: AR+sD10ZHbSm2KYXmwjkmum4CcbYy68Mav1w89zw4jqnycFaCxCB/uO+3/tQ95/ZsHg
	hPMXstE0LEFNmYlnnKKYmA4GRc88LQw4r7U8KZrcxHZbn8WxrmSauB5qYG5KvK+TwArs0kUrkIn
	IBsPMpcCvIcM032i39uufdlhnHpCGQ9xURYyS5L+W9YhwHOwVXk57YKyh/fidleBkHiPMBEd2I4
	Fk2kpU35wKJFOIadQTmPjHjlz1aJTWQ2KCCWuLeZ4s322DY3MAdEv7Gn850ZLln3Kysu+se6UoU
	jkq1noVUuBd4LPRh1vM4ec6wabRGo/aUFFs7jV6pdb1j9YloPB1UiXwjdhaM/48vf0AoWXym+lT
	+eNfvNf6xKrbaG18kUQrFH0xsqC2IN7teck3OFmo/UsZ/viu2jE4FuA0mUwxXIaSiXnp8kbHPzB
	SbLVREETKAPOFeF/vWOLbJ1AWqRwdzPsfQZj6a
X-Received: by 2002:a05:690c:2784:b0:7e8:a091:6c4b with SMTP id 00721157ae682-81f4c1c1d2dmr953507b3.24.1784754739786;
        Wed, 22 Jul 2026 14:12:19 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4392:41cd:1ce2:e391])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f3dc4422dsm12662287b3.13.2026.07.22.14.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:12:19 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:12:18 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Christian Brauner <brauner@kernel.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/20] landlock: Split struct landlock_domain from
 struct landlock_ruleset
Message-ID: <amEwEUKyCPNUxITb@zenbox>
References: <20260722171159.2776765-1-mic@digikod.net>
 <20260722171159.2776765-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722171159.2776765-4-mic@digikod.net>

On Wed, Jul 22, 2026 at 07:11:35PM +0200, Mickaël Salaün wrote:
> Switch all domain users to the new struct landlock_domain type
> introduced by a previous commit, eliminating the conflation between
> mutable rulesets and immutable domains. landlock_merge_ruleset() now
> returns and allocates a struct landlock_domain, and the merge and
> inherit helpers move next to it; the former static insert_rule() is
> exported as landlock_rule_insert() for its new caller across the
> translation-unit boundary.
> 
Seems a little confusing that we have

landlock_rule_insert()

and

landlock_insert_rule()

Maybe a rename of one these would be appropriate?

Otherwise looks good :)

Justin
> [...]
