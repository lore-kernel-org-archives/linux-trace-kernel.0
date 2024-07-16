Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848AFC19;
	Tue, 16 Jul 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150146; cv=none; b=KcvXKjxkCojyfG2FT2t9KB88laDSkW9QrZPjujvIeynyv68iQOH5NeNFkT5fF6y07SiLakxN9ZinzDExPYI/AesfaxfdfBvhszm3Cl82Tr9EG1WdgLTcBL1jJ9zKzULw3TWXRQW0udfUKXd6f1+q4wqQGnj4v5lk4Jrav0fgX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150146; c=relaxed/simple;
	bh=Api8rTEaonguT0SIMf9V8YbSoAFuxlHlGlQ4YaD/MKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uO5XeUiGhMhq0PIslq5q4oCxFnvNkVrFU8XAEGxM/CxM73uW6JKYX4dS+RwEwkzS4HeahsDtVaBJVugJn1St/LJ5YUlLYTPIhNIN9ahsYO0VTZ21q04P54Jy80J710TkGlLDznJ74QSvElW/YQKjIhq1/3YA2MzoNgFTrs9ZmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LkfFIHP4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LkfFIHP4"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A749418B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1721150144; bh=y/A/P7Uq5eegIK48Pp95ExW9vNlnKxMbalcpTCEgVeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LkfFIHP4+rWv5sy1heCOYvWrP1FJAHoPHjK5U6+oERq2V10PsWNqcb+6gOTbbJi3B
	 58ptzJCMLsUDW4NMhkTw4XsR3pGUPxoZf20WOkl0oFOgWWXwBa0GzaAfRG8CcMX2Pc
	 v0DLdPm4gMAQvsK8ssbcKc9ScjqvWbz38H2fztbLlVIQJIV6OYP5DSYabpfWVqCSG/
	 xwrjD83KNXRKs+OiKJivgj45oDaU5PTcRm4zKKA6T+4haJGW/n7CReAgP4zUPLVpQv
	 uSjPsBW8f9Zokxv7FESu/1feqceGOmXyzF6jbMVdsmePlZzB5udf+tK3VUFEXYuEmQ
	 hkU/ZNDNqj69w==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7A749418B2;
	Tue, 16 Jul 2024 17:15:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document user_events ioctl code
In-Reply-To: <20240715181413.1157-1-beaub@linux.microsoft.com>
References: <20240715181413.1157-1-beaub@linux.microsoft.com>
Date: Tue, 16 Jul 2024 11:15:43 -0600
Message-ID: <87msmhtg00.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beau Belgrave <beaub@linux.microsoft.com> writes:

> The user events trace subsystem uses the 0x2A/'*' code for ioctls. These
> are published via the uapi/linux/user_events.h header file.
>
> Add a line indicating user events as the owner of the 0x2A/'*' code and
> reserve the first 32 sequence numbers.
>
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  V2 Changes: Reserved first 32 sequence numbers for growth.
>
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..d953549f0b2b 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -97,6 +97,8 @@ Code  Seq#    Include File                                           Comments
>  '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
>                                                                       <mailto:alexander.shishkin@linux.intel.com>
>  '&'   00-07  drivers/firewire/nosy-user.h
> +'*'   00-1F  uapi/linux/user_events.h                                User Events Subsystem
> +                                                                     <mailto:linux-trace-kernel@vger.kernel.org>

I've applied this, thanks.

jon
