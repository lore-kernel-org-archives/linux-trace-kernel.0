Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72723B637;
	Wed,  9 Jul 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088183; cv=none; b=KhN3a2hehbRBqxYy7aCCXeZ0F3yAB7A0Ayu/CMk5vBlMGfGUAvbvY9zOOVebdDOXt6MPjpzrtr4WdEsitRuNNEZaMFo9gpsjNmUWwGtmaChqtUMDasiFGiMx6l1PWPFx3FpP4rbdsJ9ukXKagUoP0Yu+l1mg30d1oaskxWIO7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088183; c=relaxed/simple;
	bh=ty8dx0iYfVULStO7ur66hWlNQVb5KpaOASSPxta284c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIIkcANjWS/XTwG8LaD5odTSfAiKqhZvK/QtgCiNxD54JAvv5FkZ0Z5jgXxBmkHAtJXakkPl4N87oV2JL5Nz8ykWfoBIkBL+J9rPIt5PAQ3l5r7CljFriyDuIk+7AA2+Zm0mnICHBCnJfX+j6tgwVRUyP8sLa3cemeqvzie4lUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EaNu3jyn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zzKIZjtR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EaNu3jyn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzKIZjtR"
Date: Wed, 9 Jul 2025 21:09:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752088180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUBFQDuqZ8GkOGjWlzXp7+zn0YDamzbquE8bBOdq0OE=;
	b=EaNu3jyn/PxNV88DsbYBXzL8Orjct+EZzT7WD+viD9zu89YNLw/7bvkoGPqqfQ66+zHb6Z
	0KBzwk/ShfdJ86KFheoBZDX9lsYnoTu05VLKsEA1FUVzPmTTKe9VvZSlROdv9vx+T8m4Mj
	nt4r86sqo7fIEZAivWzbo8bnzxW9082SIMIHnDYUoKWPYTlH43nTwB/bD6IXQoGSqSQnUY
	gspLp+cneJVUJtOnY3hQiRpErMc7P9BOh9Pig64Bc39XpvJFn6qRieAV+vLVEfm6rrha7V
	aaWPyqRyrYGBLDFYYNiUFTJv+P5SEJTAqIIIEjK8QcFeOFQrCgYiefTxJK1bKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752088180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUBFQDuqZ8GkOGjWlzXp7+zn0YDamzbquE8bBOdq0OE=;
	b=zzKIZjtR3K5RZYjO2vVoVEVCc83Zep9JptZytN6rDVLGIrB77oZGSPglCrTGc2z1wxclyQ
	8EDwKxaPpIMX8UAQ==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 02/12] printk: Make vprintk_deferred() public
Message-ID: <20250709190938.8KErh6st@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
 <25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
 <20250709144914.6ee7199b@batman.local.home>
 <20250709185334.uFpAU2mC@linutronix.de>
 <20250709150452.6646c168@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709150452.6646c168@batman.local.home>

On Wed, Jul 09, 2025 at 03:04:52PM -0400, Steven Rostedt wrote:
> I could do it, but if you send a new version, it will keep patchwork
> automated. When I edit a patch, the status doesn't automatically get
> updated due to the change.
> 
> I know it's minor, but could you send a v13? Then when the patch gets
> accepted in mainline, it should automatically turn to Accept in
> patchwork.

Fine for me either way. I worked with other maintainers who prefer the
other way, so I had to ask.

Nam
