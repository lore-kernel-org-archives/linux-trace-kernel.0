Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6142E266C;
	Fri, 27 Jun 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033873; cv=none; b=ht26HD1AgIz7RVXRvSW2b+ywYuacXEBxILMQY6BgNkzow4i13zPHzQmcajV42K1UQYwtq8+8N9pUr3jx+bf/qtGZB6yAYpLz5xcs5BRWrnueuofSV/JswxlH/52aX8eqmwMyJGhBStXZirtJvUMqxMz0MyCtqSqXfQmY71Zqy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033873; c=relaxed/simple;
	bh=9N4BsFtxYHDtZ6fcQvtVbeKzC3miVFJq8VROpg0ox40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpWc2MICl/npf7tRi4Spc56F5KzqDuVUiIVOJcNvSpVgS73M4svsxGU5m/HB6kbpmcq1U6rqlbn1A9sbBwXJNr63JYIA4ohj1EGSZacDooq9pu3VFEXVdPNoChU+nbuUBAKzoR2S6Afndjnfln8OsjrgmtdoC+aMPU9TiYw4vCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rz4iNDCZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YUpJtwtp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rz4iNDCZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YUpJtwtp"
Date: Fri, 27 Jun 2025 16:17:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751033869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Ide64yaresq/HYNRHld+wPyxzNMOOriEtiS6XtR3U=;
	b=rz4iNDCZFpMYiyWYIU5H4AxyIrulVw7rHFnmaTsHW7GLdDAi35egu9Cy/Go/z5xNpdSDuT
	qIEeHmSnROIHZiMZhs0c5EFYaeUXB915AXIbk+LNFBSDkRGCKhUL8DG0vLbpbpTSZ+0r85
	7+rwVae2ckT2kcTJ8HpZwUnD8b58OcqQaG0nIvsZthuBmhPP7kitkt0gbVODvZCc9TX254
	19r1RRJcNnLT18EuFAgR5o1afFuemizjwSe/xGE46OFA1Lt38EOxZxBB0ThhN6kaV6R/sR
	8I2fKRoLvtl2FMR0vn2fqQf1ENXYhacMf0t5vta2RGzqbEnLJzR1x6178G4WqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751033869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Ide64yaresq/HYNRHld+wPyxzNMOOriEtiS6XtR3U=;
	b=YUpJtwtp9N6uCkfrsLnmHK8k9MoVqbi3i3exwveAUL8kDDRw+18ZwOXo79Jl6ESCOg6Abf
	xgGAAyMIQazhM0Aw==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 00/19] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250627141744.yTIdgd2m@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
 <20250627124248.fpuBrdWJ@linutronix.de>
 <20250627101631.59bd7ab0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627101631.59bd7ab0@gandalf.local.home>

On Fri, Jun 27, 2025 at 10:16:31AM -0400, Steven Rostedt wrote:
> On Fri, 27 Jun 2025 14:42:48 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > Is there any chance this series could be applied soon? I have some more
> > patches which depend on this series, so it is holding up the show. I think
> > Gabriele needs this applied for his patches as well.
> 
> I'll try to take a look at these today.

Thanks!

Nam
