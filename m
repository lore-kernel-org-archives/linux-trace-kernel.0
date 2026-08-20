Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFC410D24
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222718; cv=none; b=K7fl+s4Ko5Gafxw3uxl20U/BaV5VZSD1WJ8UEn/YcYIUUTDVwoatiwQ4aoapo278VG6Dqv6tDv3zW64ZBdN1Y/GQqYpUOfkewTdL7Y4rm5BHFg3jTqlzOwgeC69gqzfmd5X8beIm5/+it+0I9amtSMgDb6xvL7Bz5kK51Aw/zEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222718; c=relaxed/simple;
	bh=s2DV6aiUDlhhJrEieuWVDHjMawqLaOWDdtsI/zGKjI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNiivVTbT7EXTxlnoOdsWEGobDYk4d5vEpg9xoO90nmj4Q6r7gwKYZBkaq6DgfdO0naMysO9PvBCvrlWrInF1WHzDtMmfYWLfqkdaszkcPvMwYNfJIh4ymsXqR7eHqadF5iV8dZ3KG8uukB4JZhvQxZOnRl2DZ4plX2qXtpU0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lb5m2TR9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lb5m2TR9"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so1367165f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787222714; x=1787827514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHW7GNPdc6v3nkxo9K3w/f4XcAk4BjyG4NYESGzqVro=;
        b=lb5m2TR9Apnr9DvGHZWyW+vaK8ppda+GPGttAkOWNxToLXtyNyHSdWB6lezRMsmpZZ
         Hl74PGKLd82PFyp37m2i2lB/UdYZqRYfh/KigoW10PMQiZOuQT5fdYVVDfPDVdrFoRLe
         6yDsIrb2v92fpjWZk892PTPtp7YuRZZye6hfkhpZ0xwXqDwnGXjlTDWLo03nOxV+qy/f
         bPkT/ZTH602xZoX8n3yz2CPwpTWHsSPMnAAGsJm/XwlTuCJDupU5N/UZVjYzmKjYZP1n
         cfHh6ikbeuFyWoM3p45p/Cy7IRwAKV+MdvohkRZD1nb/61Et/HUx+j/Ukd61+P6XEx2+
         TVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787222714; x=1787827514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JHW7GNPdc6v3nkxo9K3w/f4XcAk4BjyG4NYESGzqVro=;
        b=HHfaIRZoCNXwjDhIWLkLL32fCBqnOh4t0pfEcgJkOzbo885Q3RDjOXN1tjvPrIlqZb
         zDpn3nMrEux1YCDfTul0/ljAck4iLdaj7VSewTU6Be4tMN3e6PUMHptMJcojSVl5JTWW
         9x46QXK9v6HtSneOsGc0IQkUX7Eki0FZWD2vxAmeew2uwqxttcrDtP2pDyrG0jfMDclV
         k8HePnTcapIRFaYsCVR1FUS9YrWlHFrSWv872DBjz+hAEvFPy3eKHN/DtqybTJPzw0Et
         EpUBsnj2QZE6F2cSSIiArWNxY2d8Jwyl7U89WSXBcprzj2hSn5Qjk++8IZ8CmxxTeruD
         7teg==
X-Forwarded-Encrypted: i=1; AHgh+Rpi9ENYl+OtoSGZJaAb/ltfTxhDKhW1/CuE5+VbqZgRkxjoiTZ6sZA8L/+YzHjUXrPPjEwoOnzyBPKsaazCYiqgrws=@vger.kernel.org
X-Gm-Message-State: AFuF++nAjrenkRDG9AfuC7sLjjxyaRmRv+HTPd8jdtEiM7UOH67jjZ9y
	V4IZIyvmmn/vl4h5gieSR0G/gjUspGqeFcrkVYIPnoaGLOYXPUaRnHwWErFhd7w8RQ==
X-Gm-Gg: AR+sD10SG6wowsf0apHxHuFiUd2qetVqSzv0cOA5vaXKBecAEHnkRAdyAseJipvbKak
	/Y+HquvQpqtPoJ8PxOiXqH7JvxX8I6RX5zj1weFhG6/nFBKX8Wa45wwqxhFONXjXjlygWprV3Dy
	/8+56qXGl26fWdQfaMxp30n8YRuP7uzP5BpCp8NhT9Q96+bgvhCQV0okdvNSE2YeDeQDuHv4CWi
	N4t7Ee+0pMNfg+SIPrfgEVxthSMGCKfjGpr06mmU7twsiiOADXTpDOZik38JwFjeLyS/c8uxCwB
	BBCuMTEkfak3QKIJbBrt2vzJkcekaeFqGncKjuu30tQpQeKJ1kGxOKkg7xzS7g3x4neoHxGGuxm
	DHt4SPTXqUoqVSd0OdUD9+amCXvyg2WBU50w+T6yzuGBKj+f+spxkJVNKIIOo/gaaZ2x0XSJy+K
	TT1Bnj6qVuLHkRVHGnByWygvWsoPiWAbRMDbAasa1867TCXEe6w5bSYvM2pvFr23VqtuH0YH9ye
	DYlMCzCUUUTLUM+Z1s=
X-Received: by 2002:a05:6000:2405:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-482b1fd970fmr18114147f8f.15.1787222713504;
        Thu, 20 Aug 2026 03:45:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d956:c85e:ab42:2c9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b7d3asm11766234f8f.23.2026.08.20.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:45:12 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:45:07 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/19] landlock: Split struct landlock_domain from
 struct landlock_ruleset
Message-ID: <aobasxUDQ8b7GYXl@google.com>
References: <20260811094338.288094-1-mic@digikod.net>
 <20260811094338.288094-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811094338.288094-4-mic@digikod.net>

On Tue, Aug 11, 2026 at 11:43:17AM +0200, Mickaël Salaün wrote:
> @@ -45,34 +50,27 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  	new_ruleset->rules.root_net_port = RB_ROOT;
>  #endif /* IS_ENABLED(CONFIG_INET) */
>  
> -	new_ruleset->num_layers = num_layers;
> -	/*
> -	 * hierarchy = NULL
> -	 * rules.num_rules = 0
> -	 * access_masks[] = 0
> -	 */
> -	return new_ruleset;
> -}
> +	/* Should already be checked in landlock_create_ruleset(). */

This comment is now itself living within landlock_create_ruleset().
I believe this was inlined from the original function, maybe revisit?

> +	if (fs_access_mask) {
> +		const access_mask_t mask = fs_access_mask &
> +					   LANDLOCK_MASK_ACCESS_FS;
>  

—Günther
