Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972622FDE6;
	Thu, 27 Aug 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837809; cv=none; b=AtmIhKtEF//qtx8u/oG06Z4DLQqiGnNzxb/Q5nBxxE/Il5Q3A8yifEOTSFsbosOfGfrHYjKiCdRo7ZdifEb3HwPBT1I5XvxS5whDqO3rJXwb1Z+vLnkIZEbjXkLz1sVtciLDCZj8oMRw+6mRMI2fBLY+ozU8lsXePLyQWEDbN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837809; c=relaxed/simple;
	bh=y77JdbmbQ+p8ao/XsJ+yBKEj/BzsMs8447bJoe6PuaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8w4szGhoQIVnjYgbgvxpBnVjvfwT3hvx+8MK+sPetNYLiAlnHWzcRBXovtDo7y1dQfHrTJ/t0Exb5bJmi7D/iYV4TBvVfbRekQoDIXPB/93LO2up7QhvySUzDiR4x5uh4ipYlsiHtslckr1YnYtruILESvx5P8OYB6GCQAmafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyD0UtL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyD0UtL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D881F000E9;
	Thu, 27 Aug 2026 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837804;
	bh=AFrAUexgDEbcFroMIVFfeYtWH8e4l4ZTKASZuHJWSKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VyD0UtL0Qcckx5OVhnXQ2dB8+QfpjBYNsnjlJJt6CJW91D78QGnnFOJwjQPpld9PH
	 sXF8ZSk7RnN9mFQphO9L3XzVfDJqMBzWmNmdisg22MnPdmkBaxlY1V+Dp+V1ZYVriR
	 AFHd2SbPCU7FT2GF8KciIclmpdLXTrah887vD59ZivEBYYBbsARbQenrW9EAGvqSUJ
	 g1Aa2MqbkgvGWaJ5IaV7ycTMcK77GdM39Bn+M5/G1Ax9PktIG7jpZK3sZB+g214lzE
	 kf9kFGloctZ5NxMPt7csp8dyzbros+tlxniHa/iZQna1W7Mo88vJFvx1BcuuxI92Ut
	 Qd2tYjl4Qe6Gw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzaHZ-000000031xk-3ZRU;
	Thu, 27 Aug 2026 15:36:41 +0200
Date: Thu, 27 Aug 2026 15:36:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: pull out add_taint_module() to be public
Message-ID: <apA9aTiIpBz4inof@hovoldconsulting.com>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>

On Wed, Aug 26, 2026 at 11:19:32AM +0200, Greg Kroah-Hartman wrote:
> Other kernel code might want to call add_taint_module() so pull it out
> and make it global.  If modules are not enabled, this defaults to a call
> to add_taint(), so all is fine.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> -static inline void add_taint_module(struct module *mod, unsigned flag,
> -				    enum lockdep_ok lockdep_ok)
> +/**
> + * add_taint_module: add a taint flag if not already set for a specific module
> + * @mod: pointer to the module that caused the problem
> + * @flag: one of the TAINT_* constants.
> + * @lockdep_ok: whether lock debugging is still OK.
> + *
> + * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> + * some noteworthy-but-not-corrupting cases, it can be set to true.
> + */
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>  {
>  	add_taint(flag, lockdep_ok);

>  	set_bit(flag, &mod->taints);

As has been pointed out, this crashes with built-in drivers. If you go
with a simple mod NULL check before this call (and updated kernel-doc)
you can add my:

Reviewed-by: Johan Hovold <johan@kernel.org>
Tested-by: Johan Hovold <johan@kernel.org>

Johan
