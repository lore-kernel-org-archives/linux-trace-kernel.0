Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEED15956C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733007816; cv=none; b=kj28dTHnceY4nT1DafiI/aHl9UH/ZAcfIJ2serbOCvEXDHxCdi6k/B7ucPPbzWT2gWYifUBc39LpRGbQWlUdnzYKQ8tyAU8K9mvpRTRlhwH8I1U6IBA5znq0cPda6kVsessQgWjRi/+go1ynPMzC7p6A3Vj7NL4k9kIdNhKQpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733007816; c=relaxed/simple;
	bh=Oj23kvXML5YxbzImIPjLr7bu4A1f9m4DYN95To+LWn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eez+xYfYUpOIfDlpJm38m5/Lxumds87wNXPmjwbfoc3MMFiQxIXbvO3TNgM4Pmpms6JsbaEF4vvdS1Nud2q6/yE66gzdswMWnXupYR46Qpg6msA7bBs6BSw9Ug3pta+MiBK/ebiuC+g6uw1d8OxKf7V0XE49UR+PKr8dTIAw1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=lq6Fg0Am; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="lq6Fg0Am"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3985aabf43so1551513276.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733007814; x=1733612614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+lZDk59n4UHv5yZ4bNmxMnAKZtUzjiM3soOA0zJRIR8=;
        b=lq6Fg0AmWbnv+5LSzi3KTFh3YXayo9bVjWEHegEzKD1fG4lRyPrktXM0BJ5EBwwrDi
         x11i/bcgfKN9gtiehuyNFu4aW/2EIZtjSM7DdP6Sqq/ePAuPqEUJNYAgL2u70ynu9ODH
         5CSz4iNHck3I8W+aQIeQ6+2PufnhycaH4xWxeQfUCLVlqt1uQ1JK0zizTHUqv4lO3RRF
         Qtfz1EfapPUrA2/VYIilB+3jDzSPO1Bq2kFLciSsnDQwLx9gXuMFP5+ifGsLGwQnA+vH
         8Cwj6X4mzQyOc2S7Jl3/XeW9xwLpzhP7d/t6cvZJP22pzRZUFqYFDNt8ExlMuAiWVD3D
         x0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733007814; x=1733612614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lZDk59n4UHv5yZ4bNmxMnAKZtUzjiM3soOA0zJRIR8=;
        b=F1V352MwQDwQyge7Rp2cuqrJ1en8UuOJVgZSm86hhC88aiEhrDcikctVCtXi/s5MZ5
         irWDSDY0QtHbcVRuugHDdVnOs1Fx/NiGfqryf2FAJHOQhEShVYjLnkn8bwvujP/NAwfO
         j02KUBbH5juNMrUJaxFcFw4zzk2irqCSceKL6GG1vY0sdzMXlO2o//s5cPf+/tRmbEIB
         8P/B1RJu3MjuNQDmM2isFclDjtTgLpPsnSfAQ9AA4sXZXfJfIfh4dDVbIkM55Z2B+vIA
         8E5KRYrlVV0F5LzvfpfYaRE1ww04wBAp4OegrTTBYFL9L3DfEsboueVj1aEF0BGohugq
         nTaA==
X-Forwarded-Encrypted: i=1; AJvYcCWEsvMhXE3Pp5uta4+qEDF7ksAJMzX18z4Bb1/YQ/MKNfoQdCZ2yP6oMapJ4nKUtUaMLJ2h2a5swYACr3/9PeYc2ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpV0+2m35kLwttNl9hsCmXhLMDiAAnjalh6plPv6TXgCg5Xmmm
	Nq0YAgG7BxCm4XvuCrBG5Qy6O2eZf1PJ2BwK4Me5uB8OmOdMTfjwCd6j5xEhHzVgqWmcnyEOo0B
	IgT2lSuQ+nj9o7eitNAHJQ8SVKULD4rO5TqGVSg==
X-Gm-Gg: ASbGncsB+Ni2P6W5Atbj9vF4VWCCfslx5gcF0KGLq1fZMOQ51WK2aM2Ms0DaineCliG
	b3LCEMophM9SW3/ZxQwscW94A0OADXmM=
X-Google-Smtp-Source: AGHT+IH81R4XFg2CPj0gwX0HCIBF9TK4lO6eQU9i9Eh6UvUy1XLoSg/49272JtHDhspwSlHmAL7DhLTLqjgun/Hp2yM=
X-Received: by 2002:a05:6902:1549:b0:e38:c692:14a4 with SMTP id
 3f1490d57ef6-e395b93b17dmr15727852276.36.1733007813990; Sat, 30 Nov 2024
 15:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <20241130160815.4n5hnr44v6ea3m44@skbuf>
In-Reply-To: <20241130160815.4n5hnr44v6ea3m44@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sat, 30 Nov 2024 15:03:23 -0800
Message-ID: <CAA8ajJ=Grm47nKZ+Yp-TEXAFfyoDOkJ9Kbc+NnUOx6ehg0o=vg@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

 Thanks for the review.

> I was also going to plan asking Andy what is his plan on making
> switchdev digest this.

Since switchdev switches don't seem to support this, I wasn't planning on
making switchdev digest this. I was thinking that it should just
be disabled for those hardware switches.


>The switch ASICs I'm most familiar with can learn
> on inner VID or outer VID, but not both.

I don't know of a switch ASIC that supports this.

Is that a problem? I thought that it would be OK to add features to
a software bridge that don't exist in any hardware bridge.

I've tried to see if anyone else was facing this same problem.
All I found were concerns about the fact that the provider bridge
needed to learn all the customer's MACs.  As a result, it looks
like 802.1Qay was created.

It seems that 802.1Qay is primarily addressing a concern about TCAM
limitations, and decoupling the provider and customer networks.
I think it's possible that 802.1Qay has inadvertently
fixed this issue for provider backbone bridges. But for my use case,
I'm not concerned about TCAM usage. I just want isolation between
the inner vlans.
