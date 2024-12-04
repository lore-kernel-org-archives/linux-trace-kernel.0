Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CB1953B0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301458; cv=none; b=iRwoVx3xR8eSQX7FAB9S1l4s7FFPV8ehkufT5ACwHsnGJ5k29CVcpUtnGCpAXEVE0Sq35a2FZY2NaN9UADR3OcH8bi4ihBuDuCo4M7p3TlmnGXk7GLTzmGasCg3BJO7yu2Dn5iDa6eSgWReIH2OzvHRnESWCVAP7cv4dwlrfFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301458; c=relaxed/simple;
	bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqDPHDiZuC4qXqm1z99VSZxR74Yew8AKvjEU4xASCtQNPhBOWUIfU81Qd3Xy4q20sl8RSw+rhNySVdCOuO6VzK3oudUdWN/cg5FPJVXRJPzFNN5qkre4SFw/pdhHF/F0bKE0WjmVraiyiiSl7cjmI1+ytrxcSCeOstr4g5p9IHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=ytvZW3X3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="ytvZW3X3"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3997835700so3347576276.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733301455; x=1733906255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
        b=ytvZW3X3oQHrPd7ygT0R8/0HSkVFbHIAiODywwp2E5FlD7hmU5U+E/ZYl4dJYT2vr1
         T/4ESlFZbanOn+Ip/n3bBHXOhM99SUIEMQ5Y2oidmeYModjTpEH5tMjUDvPnAygNJvOp
         eBtVi2ZYiZI4TH2yK2lrqrFbhxt5kpydRTXuiXdbh9D4/LzNMCP6ebRlaH+wIfabItRz
         WFlc01suVPmv1uvj134eGowQWoesCT6ekqETucRKsEEZ2StmJXwyrMtfYuzOLAUtEWFy
         FQvTD8hzoeAlyIwiykeTjVobuvzzICfaYJw2/SDfZI/QItHWuvUggariM/43StsYaWn2
         0wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301455; x=1733906255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoVke9SqFUpCaQKo+qnhyQ0iycqkcohJkC/+ji9nimc=;
        b=MO6GOA9s7HE+PlZpcmWllhPdg4d385RW044nZgPKB2ELlvO0hesTaorQYWy/CFxQoQ
         0Mj3aFNCRg/ZDRl9M5Q5C7eN1ArYUSAZeg58aK4Wfd4Whx9tB3xikOzW+f1dVaUEjhZq
         NY9hJ2+joQYy5cRN+ae+HOnJWikaLgR1b+xE2bBuC6kYLJJFN4Iyz2k4H6trCkKpSyh4
         gQo+O2vqmRwRIJXMkkuRmGGhJs5ATovrovvbR+2ePW/T7Pbv89O+98s7qtqUdTZkeCzS
         /vgNG7LZyqzgAgQDdTFy03IavTd3gbbcxDP2HRdpr8aDmrxa8LuyuDIC2NN4dJIB6nhV
         oMCg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0UC7B72TLJIQKfF9Sd9bpbsO+CnYSFSdWz0CsS7HAfgaxag02Q4d+p2jMJLXKglsDaC3zQV2AaSQhyw6SqlyacM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pKmqm5X21pMG96+AcK1LCnYhZqW6w2rkbI0xaY++QeznP1zA
	65GzL57JPoGvlSCKwLhJIC5cRaeunbGyoGqLWALSBaFJWvk926lDY1LQu8qqqRB0I2dRFexO0No
	96V7Flh2ErAazqeRv+3C4vKbG46/AxFGU9VMBmA==
X-Gm-Gg: ASbGncsrgTJQh3qMlv1kAiGIhwDPmcxn5Wo7foR9vXVHg5MNnMkEB7RD08B4hVDU4pf
	QDFnwjmv9Saeo+t/CmBJWeBuTjvUCmi8=
X-Google-Smtp-Source: AGHT+IHrKkSgA4hGlK8jn7mrWKSIy07H4RXZ4L/gvYx86xaKYNomvgbtV66jTpE9OVKxPCEslG9WFAbqVeHjvw6aGX0=
X-Received: by 2002:a05:6902:150a:b0:e39:9032:122 with SMTP id
 3f1490d57ef6-e39d4389535mr7493688276.44.1733301455300; Wed, 04 Dec 2024
 00:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf>
In-Reply-To: <20241202100635.hkowskequgsrqqkf@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 00:37:24 -0800
Message-ID: <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
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

> What stops you from changing the 802.1ad bridge port pvids to unique
> values, like 3, 4, 5... instead of 3, 3, 3, and making each other
> j != i bridge port be a non-pvid member of port i's pvid?

I'm not sure if I understand this suggestion.

I tried to draw out what you described here:
https://docs.google.com/drawings/d/1UcOpENFgr-s6p8Ypwo-l4yTvtUZFM6vSLxLiX2FOMLU

I'm not sure how host A can communicate with B with this configuration.

Consider host A transmitting towards host B. When the frame leaves
".1q bridge 3",
it will be tagged with .1q tag vid 7. When the frame leaves the .1ad bridge
heading toward ".1q bridge 2", it will be tagged again with an outer
.1ad tag vid 3.

So ".1q bridge 2" will see the frame as having an outer tag of .1ad vid 3 and
inner tag of .1q vid 7.

Is that what you are thinking, or something else?
