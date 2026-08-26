Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A741B8EE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751203; cv=none; b=f95W/2qrv0+0gByrMsMAeeTpFKzWtbEC09TzTFJq+vyXKmDvb1rVXQHHTYs2kY+O/61sH0AqXdnLQlKW3gsggUsGKJanTt68o5nnNmlZAE4Dw/JddijBcopSnRzt4wmCjQZboq900U0R+H3EV3XXHFUydS/Y7Nonpwn6m8stYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751203; c=relaxed/simple;
	bh=skh1J20miHyQI+YX6SjrUI0pPMNxBurFeVoXPbNyAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMdFz/pXcX/hcrgg6XlFHm7KxlIqMqAwx7jsjeP61caW30eTMdxFY5c64tE4H8kW4nqMZYIruJCcLJlFJG7Um7OQw/ALlhVZQ0eMqvSDEFdqOgkdoOk+F/wR0rlWk0q28Xl6HuuvL2jWMAXsndJi1EZ4UlcXElvHX7S9MES1y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3jprUtV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3jprUtV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e1bfcc63so661633f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787751200; x=1788356000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eDeYb04JA1wKUlB+4fT7hBu1dYeSHzQSzUnUA5UoiTk=;
        b=c3jprUtVQbhETdxCm6+ylXMzRdkNb5d8VOq2/82y9Gnsg3XZY9bBpfHfOBKK3nLgLV
         3jxszFUSj7uWNo9rdwFjyJr7pX2PII0A9DohLTxTf8b3KT0BCuWUnMqb5Yjn/2zcJEPN
         en/lU0QsLn7hSUze0FUqtrG7JwN68xGMbZNSQO/YupFlSTN+RWuj5dzrvqSW5DgBp0UA
         VZSZRHegLfpTO5rPb3EgXN4Fj9ISh+PjEosJp/rcWM1PbuKki1kOhdh+JXu9ub8TTmFS
         GXghIHP0hcos1PTLWyIGw63Kjxp0n8n3PWjkTnMADzJmmjILNp4eBa6Fex07ZpF0Cz3o
         Yl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787751200; x=1788356000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDeYb04JA1wKUlB+4fT7hBu1dYeSHzQSzUnUA5UoiTk=;
        b=ij2qTrUjsOGRZjLLvHz7bTg4qzvhD2VPNsly1bj/bsd69E5z8mL/lBXBMKYyKut9KP
         iHNLYuJfRNmhYfWMjWa9C5+4djaqmzWxh6qE/V2ijlGtXykDdM92BwiVAJH2HMEFZVZW
         Vc7o88booSfy3wZ+h4JOqVLGCL8PhBvLuWjDE3SPM+83ywWayV3LyJ41D9Wz2R+LWmlU
         RZUYG1hRajqM5CZ5yPBhGBgTdg6B2J8oAiLjDBw0Ls+YB/v7tSGaKPmFA49vM4oqowKS
         Js82Wj53CMpDjeG+ZqAC0Owb6TeTqxDwp1Ywgfhm01JdfDASU0EnrUvQM4DLXqm3OBVK
         /gRg==
X-Forwarded-Encrypted: i=1; AHgh+RrRfKF66LsZt2BXg7y07jm+x8w1K2GOV4hgXQWRsDJROYbz1A9iVexZJtVggqJF2QXlFPyhUpGRKgnXm8EdyGayBlY=@vger.kernel.org
X-Gm-Message-State: AFuF++lLT4yoTT3OLwO2qzPtf2nHQFcCUvcdKYaizCun3QseRvkRA6VP
	gqlqljGcW0xaWkun+7HMlcGgCEex3m1o5aS6uaf2synjx0NeN8i4ySa/
X-Gm-Gg: AR+sD10I3YRcrToPPv5MNPz6N7YESLIMHngJpdXl21zkRjxj1/P8ts5tWHXn04gmHo5
	FRkbQxAv2/gYmYzObKykIXkvhRmQoOPaJd4Ok37bM8Fp/MRUv6iY9+D/Z7Zea9YarvdYV49Gt3C
	i7PtdRgycC7zzFcKMQEpoWgGVlhZuJJ+8NaKlqQJubQTDLRXb2e0e/K2W+t8dwayR2BXxj2vSga
	uHXaUsxx4JBohXlb4mDYs/k8gy9Y0PUkough9Mfau9+pDZCdaZG1xBkHzQzhg5ZrwSd+ZOsIjhc
	5YWIEIA2uFfLha4HDx7DcalpgK0yPa63oiRNnByTD6L5T8/4CQRSCljLMjToBz8wu0JI6wY7vt7
	1X5HoyETlTqV/gNvnFeN6IsI48BDu9CE/xrMwkQQs6zdzz1Oc//8QAObT/Hh2GDBkFIP6pb8mxP
	PXnCZ4EeqX7e9m2KusujsQBFeTa2afjVVDEwEHjIf8qXPxFpY8lmOsKFfbmzr2SI2WZ40=
X-Received: by 2002:a05:6000:29d2:b0:482:dfaa:dfa9 with SMTP id ffacd0b85a97d-482e26b3278mr4456632f8f.7.1787751199354;
        Wed, 26 Aug 2026 06:33:19 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28f6119sm2777848f8f.34.2026.08.26.06.33.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Aug 2026 06:33:18 -0700 (PDT)
Date: Wed, 26 Aug 2026 15:33:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20260826153311.6340efcd.michal.pecio@gmail.com>
In-Reply-To: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 11:19:31 +0200, Greg Kroah-Hartman wrote:
> The ability to add and remove devices from a driver through the sysfs
> "bind" and "unbind" files was created all those decades ago as a way
> that kernel developers can iterate faster, and provide a debugging way
> for users to attempt to add a new device to a driver without having to
> rebuild their kernel.
> 
> This api over the years has been abused and recently come under a major
> fuzzing "attack" through tools like syzbot which decided that it would
> attempt to just randomly bind any driver to any type of device, causing
> loads of unneeded errors and pointless kernel patches to be generated by
> unsuspecting new developers.

Hi Greg,

I think you confused 'bind' / 'unbind' with the likes of 'new_id' and
'driver_override'. Try binding xhci_hcd to NVMe, you won't get far.

FYI, besides being footguns, the latter are apparently used to assign
any random PCI device to some VM drivers for passthrough or whatnot.

The former hardly are footguns and have further common uses, such as
removing kernel drivers to make VM / USBFS work or "turn it off and on
again" when a driver doesn't implement recovery. I've seen a published
script which does this automatically when xhci goes belly up...


I am also not convinced that fuzzing 'unbind' alone is a bad thing.
How is that different from 'rmmod' or pulling out a USB-C plug, which
may have a bunch of USB *and* PCI devices behind it, mid-operation?

Regards,
Michal
