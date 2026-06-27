Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8A17B50F;
	Sat, 27 Jun 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552199; cv=none; b=E0mne9zajbHdx+9VfFv/Pq0Q8vRP46UjATjkFFv+qGr0h9e+7r6gNOGc6Uh9EpgXmhA4I1vY2+8KWWinhV/o3/EOvKWJuF9QR13J+sddNLQTyEIXEWPqR/01Y8ad1fyYVnETJqsnKyQlsoR/1VnQlsoLItEqGOdS1mLEZIGKJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552199; c=relaxed/simple;
	bh=fKJ3hXeFES2RpNSuyJhsOx2YjBVHuGlVrz3hG6NU1J0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0I5lXrgH9cjZAXmrBs12gUgy0HuRWekI4mS5fFgWpYhMhtPbHDOy6klhUNDnryS+1Z+DzWvZJJSb52ekRZU23kTxoVR6y+k225ka2pKrmIDNkiHgCMQJYrR1Zxh/tswpDtvv+Q7HDEVwalqi+QrqDimogY4EQyksG2uET2ip/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3B79BC3314;
	Sat, 27 Jun 2026 09:23:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 8EFBB1B;
	Sat, 27 Jun 2026 09:23:13 +0000 (UTC)
Date: Sat, 27 Jun 2026 05:23:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] usb: typec: add trace point for typec_set_mode
Message-ID: <20260627052311.18649b98@fedora>
In-Reply-To: <ajPW9P6qZyhqtjvp@kuha>
References: <20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd@pengutronix.de>
	<ajPO6roV4HRZYGNd@kuha>
	<43e13854-a634-4706-bc12-723c871a5579@pengutronix.de>
	<ajPW9P6qZyhqtjvp@kuha>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 56xn5xisgfc1h3rakkp99kdu3ytujj5w
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8EFBB1B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19NYMANLc1o9IuX67SxFSTjbOUYmdbT/Kc=
X-HE-Tag: 1782552193-635815
X-HE-Meta: U2FsdGVkX18tHMH5FQKISpJCF3z3ylpEN7fnXxNGv//UlNTTvjSi55n73awhAtNwniTqbqEcZYXQnmzv/nz4Fjm2PSA1MTS30w3GfeBZ+gKYAaTBL+MGze92asptEBp13uRe9DE70U/ymCIeQbrytkXoDlChZWfsX0mrBxEVoFC3BWoav4pGtQoVCFZgm8Ah5sPXZE5BdTsZWNxBeFY9CDHvIVLve+fWUW+ScwfL4V8DEEoFo65PrvQkzLuyGpQ+D3ap3KIeHu4pIn0ytyGEfIkR0W4k9vWw8RdY1aGqXMtySSzDKMl9o2nhsGBi9lxOJ/14Q0jI0tnz0zB3xhSBKCWUQE9H6J21DbOWVJAtFlCTVGWXsP5GZnCnKNKWputKoXfxvVI1kN29X4DO63EISg==

On Thu, 18 Jun 2026 14:31:00 +0300
Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:

> > >  obj-$(CONFIG_TYPEC)            += typec.o
> > >  typec-y                                := class.o mux.o bus.o pd.o retimer.o mode_selection.o
> > >  typec-$(CONFIG_ACPI)           += port-mapper.o
> > > +typec-$(CONFIG_TRACING)                += trace.o  
> > 
> > Thanks for the suggestion. I will do that for v2.
> > 
> > I also saw there is Sashiko AI feedback on this patch[1], but I am not
> > familiar enough with how the event headers are used outside the kernel
> > to determine if that's actionable advice or if it can be ignored.
> > 
> > Do you have an opinion on that?
> > 
> > [1]:
> > https://sashiko.dev/#/patchset/20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd%40pengutronix.de  
> 
> It's correct. You need to use a private trace.h in this case, so just
> move it here: drivers/usb/typec/trace.h
> 
> And also make sure you include everything needed in that header like
> it's telling you.


You may need more updates to make this work in a different directory.

Please read the comments in:

  samples/trace_events/trace-events-sample.h

and

  samples/trace_events/Makefile

-- Steve
