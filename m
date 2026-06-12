Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23C403E97;
	Fri, 12 Jun 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283904; cv=none; b=QUnigXfqu4wn3td0ptP1VSxqPyCgRkA+OV0ZlwmJqXHqSjefz3JXjRVldh62LKe3ogf8Efhak8M7brQjX1yIsGHQD5QagUJbDSIblMItg/gP4ERXsnn7gOMBaHBwC0ZaUEbkq2qTire93Em8xD0fJs29/zIVewQ2pHNBSiE3aHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283904; c=relaxed/simple;
	bh=HjPh6C5nG7E+4F5jTueL+eZGPAUNQa12nsYHZo5KHa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+NoFieS4jO0PFYNmprQkSs0zVDiVkl5BDTbWNRIWrvhyzoUMIMLUdjxEwgLQn8kJ4phkOsy2D+aMT6hUu3yPvJMlSB1I9TpLwmr3xNdt4wCsatej8BKbiZoq6Dl3OpVRRl11HEQZ96HeBrZhhvHCt7eA5L3VA2rbJliwUpFo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=L9lxAC4R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L9lxAC4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBFC1F000E9;
	Fri, 12 Jun 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=L9lxAC4R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1781283900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKxxw6uieV2ILhmcwefOMtWZsrYBjPWiIhfSjpQIwxM=;
	b=L9lxAC4R5FKPsKNMKkFcQaETPXnQoFMnB1kzJXYy7shdojR7/3MC2596BDwEyMLwzKdIpO
	tS873JfLrs5hZRnbBrJN64rU1Uhm1aYrjzs5GGBXUuGklmACn/rILYSFH72ifqE+neKfA4
	A7VyWRhdtcnhMxwfNJXIq/jxgaWPAU8=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id f420b503 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 17:05:00 +0000 (UTC)
Date: Fri, 12 Jun 2026 19:04:56 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] random: Expose boot ID to other subsystems
Message-ID: <aiw8OIRYMjWZYhvV@zx2c4.com>
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
 <177937542892.2596845.4271730537688894501.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177937542892.2596845.4271730537688894501.stgit@mhiramat.tok.corp.google.com>

On Thu, May 21, 2026 at 11:57:09PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add get_boot_id() to expose current boot ID to other kernel subsystems.
> Note that since this is only meaningful if user can access it via sysctl,
> it returns NULL if CONFIG_SYSCTL=n.

Wouldn't this be nice to have even on !SYSCTL systems? Why disable it for this
case?

> +/**
> + * get_boot_id - return the boot ID UUID
> + *
> + * This function returns a pointer to the boot ID UUID, which is generated on
> + * demand the first time this function is called. The boot ID is a UUID that
> + * is unique to each boot of the system.
> + */
> +const u8 *get_boot_id(void)
> +{
> +	static DEFINE_SPINLOCK(bootid_spinlock);
> +
> +	spin_lock(&bootid_spinlock);
> +	if (!sysctl_bootid[8])
> +		generate_random_uuid(sysctl_bootid);
> +	spin_unlock(&bootid_spinlock);
> +
> +	return sysctl_bootid;
> +}
> +
>  /*
>   * This function is used to return both the bootid UUID, and random
>   * UUID. The difference is in whether table->data is NULL; if it is,
> @@ -1638,12 +1657,8 @@ static int proc_do_uuid(const struct ctl_table *table, int write, void *buf,
>  		uuid = tmp_uuid;
>  		generate_random_uuid(uuid);
>  	} else {
> -		static DEFINE_SPINLOCK(bootid_spinlock);
> -
> -		spin_lock(&bootid_spinlock);
> -		if (!uuid[8])
> -			generate_random_uuid(uuid);
> -		spin_unlock(&bootid_spinlock);
> +		/* Ensure that the boot ID is initialized. */
> +		get_boot_id();

I find this a little odd, this implicit behavior now that sysctl_bootid ==
uuid. But perhaps that's the cleanest approach there is?
