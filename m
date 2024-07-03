Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D281369A0;
	Wed,  3 Jul 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047490; cv=none; b=acCt0Rr5Ow9QxR85Y252YRoI67ZB8FnlO1bfEJr2a7PQzUMyK2yPRv6/sS7GLumxn0cM0wrvcbPKEBbkJYz1FHYyhOIaE9fv+m8wcgCW3CpLz9bl0LkX103FPbzWxDYciIpujTWrztndX0qUe+UQbGqy8OhMH+PGnlbnLF+dXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047490; c=relaxed/simple;
	bh=FR8dEXqV09197NPqymlT54ODyDN+miSN5IIK5LQEFUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYEjK11XqHdp8H4ixf3xmn8hHKfs7EB/Q4c9i5QcOg2PMy+LRRRbAJpzlbbke1XFynY3ZB4wmIsNrYrOmXfyoonRZTF3ZIhLRuO/HQX7lJCCvo9hapbMisc7wYj1vznAkDOCiauo+qVC5NQlGnaUJV9cO8J/FE8EL0BMLiWcSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nDTCb3q1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nDTCb3q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1720047477;
	bh=FR8dEXqV09197NPqymlT54ODyDN+miSN5IIK5LQEFUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDTCb3q1Gwtzk8tSp7otBWMEQmtdcCMwq0D96P1iJaNxuBod/FcRiGdFdcpy4Z85i
	 B9PVrC5isiSKBL46XEa2tO9x4tELi2MDtK5fLCa0wCwAeaoWSup0rNpZwbpS/TnCr3
	 X+bp6DnAjFjpP1Y3VYuEJ5lllzxe+xLZu5V0GQxE23hy3RF+OJMhCDgkhElFWaX+CI
	 25m/Df2cttNhimhEx7557SZc/yWY3nJMX5nO3CcejO0FJx2c9663gGmc7/EyZ1owe4
	 grWuUPKCKc14lTjQ1Fpt5mXJlZtQ4X77QC+FDZIMLPONNNTVtvuUwLA3xqyT2e2EzQ
	 W76iAUhQYkuuw==
Received: from localhost.localdomain (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WDwD51KC9z18fQ;
	Wed,  3 Jul 2024 18:57:57 -0400 (EDT)
Date: Wed, 3 Jul 2024 18:58:03 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Document user_events ioctl code
Message-ID: <ZoXXe8Tl9pRD6-dd@localhost.localdomain>
References: <20240703222501.1547-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703222501.1547-1-beaub@linux.microsoft.com>

On 03-Jul-2024 10:25:01 PM, Beau Belgrave wrote:
> The user events trace subsystem uses the 0x2A/'*' code for ioctls. These
> are published via the uapi/linux/user_events.h header file.
> 
> Add a line indicating user events as the owner of the 0x2A/'*' code and the
> current sequence numbers that are in use (00-02).
> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..191609fe4593 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -97,6 +97,8 @@ Code  Seq#    Include File                                           Comments
>  '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
>                                                                       <mailto:alexander.shishkin@linux.intel.com>
>  '&'   00-07  drivers/firewire/nosy-user.h
> +'*'   00-02  uapi/linux/user_events.h                                User Events Subsystem

You may want to consider reserving a wider sequence number range to plan
ahead for future extensions to user events. This way you won't end up
having to jump over sequence numbers eventually reserved by others
within the '*' code.

Thanks,

Mathieu


> +                                                                     <mailto:linux-trace-kernel@vger.kernel.org>
>  '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
>                                                                       <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
>  '2'   01-04  linux/i2o.h
> -- 
> 2.34.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
