Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27246303C87
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935375; cv=none; b=PbLp0UfgJUoAbPNCe2DjHTjum5eNgbZNyQeuuzmvooVDWaMXEoeX8vzbesPpEIRfJSax9zID9x4ZbkAHj9F3sE0XwqIYC4Yv1bH/o+/MIq0Rb6huw7PImdGNBsOaOICN/IOwlfRdPWtICWSE4X0LYLzwcVA249gOszkE4WsG5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935375; c=relaxed/simple;
	bh=A6u1a6YQWZgGECY/O411f6dQPuEhvUmxTVtif06jpoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOflS8fbXtPei7XS9j/wZI2uBuHWeZhWEecuOItZB4o0LGZyKvwmS837Wn3JtDHbg+V5DUbOll4B9eKvA/WnzbHEaclRsxNrFVMwYQc7R4IoyTZ4YLfBQziGli/OzW9g94Y/cRhn8O2Z+GsjpwiN1mT+Ge/mQLYWdyyCPFcB7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaVp0xbF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaVp0xbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768935373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PlXonULh3GS/bqx4PKXsx9hNJACoD6sYT//PKulhz3U=;
	b=TaVp0xbFbSM18yUFAP5ribZpk0W/NBzJhc6bmIwBkFMgW9xTf0VVAyrRkGkbE8HUmDU9eI
	2sJWy7XawGONv3g9niNXEqHc3SKo7WA/iMs3Z2mHuT7qX2CI/kR0aglpLnbLRc+njuQFlk
	pyaROsVCrYbOcnqDWKro2dUJ1w9QD1Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-UVyk4rt5NEuj1IFA0CghvQ-1; Tue,
 20 Jan 2026 13:56:09 -0500
X-MC-Unique: UVyk4rt5NEuj1IFA0CghvQ-1
X-Mimecast-MFC-AGG-ID: UVyk4rt5NEuj1IFA0CghvQ_1768935369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D078E19560AD;
	Tue, 20 Jan 2026 18:56:08 +0000 (UTC)
Received: from fedora (unknown [10.22.80.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 14DF018008FF;
	Tue, 20 Jan 2026 18:56:05 +0000 (UTC)
Date: Tue, 20 Jan 2026 15:56:04 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 26/26] rv/rvgen: extract node marker string to class
 constant
Message-ID: <aW_PXmp9T4Hz25rt@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-27-wander@redhat.com>
 <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
 <aW9nfu8r0YcGj0z5@fedora>
 <85c7d4762464e6a50b4318f4ea56a70202a4b287.camel@redhat.com>
 <d15348f9f6d8ed71ba3e928ae1b5da15711894e3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15348f9f6d8ed71ba3e928ae1b5da15711894e3.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jan 20, 2026 at 02:11:46PM +0100, Gabriele Monaco wrote:
> On Tue, 2026-01-20 at 13:36 +0100, Gabriele Monaco wrote:
> > On Tue, 2026-01-20 at 08:34 -0300, Wander Lairson Costa wrote:
> > > On Tue, Jan 20, 2026 at 10:03:20AM +0100, Gabriele Monaco wrote:
> > > > On Mon, 2026-01-19 at 17:46 -0300, Wander Lairson Costa wrote:
> > > > > Add a node_marker class constant to the Automata class to replace the
> > > > > hardcoded "{node" string literal used throughout the DOT file parsing
> > > > > logic. This follows the existing pattern established by the init_marker
> > > > > and invalid_state_str class constants in the same class.
> > > > > 
> > > > > The "{node" string is used as a marker to identify node declaration
> > > > > lines in DOT files during state variable extraction and cursor
> > > > > positioning. Extracting it to a named constant improves code
> > > > > maintainability and makes the marker's purpose explicit.
> > > > > 
> > > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > 
> > > > Looks fine for me, thanks!
> > > > 
> > > > I wonder if we could merge this patch with 15/26 that is introducing a
> > > > very
> > > > similar change on init_marker.
> > > 
> > > The idea was to make each patch doing one thing to make the reviewer's
> > > life easier (I think I broke my own rule in a couple of patch). But if
> > > there is a strong feeling about the merge, I could merged them in a
> > > possible v2 patch series.
> > > 
> > 
> > Yeah I get the idea, I guess I could just pick the most obvious patches and
> > send
> > a PR to Steve before the merge window, so I can see directly if it makes sense
> > to squash them and you don't need to send them all in the v2.
> 
> Screamed victory too fast.. I tried the patches on the latest version of the
> tree (which reached already linux-next) and they're have several conflicts.
> 
> I don't have time to rebase them one by one right now, let's continue with this
> series as a whole.
> As a rule of thumb, considering these patches get first reviewed, then PR-ed to
> Steve and then to Linus, I'd favour to lower the number if possible, but feel
> free to choose where it makes sense for them to stay separate.

I created the patches on top of linux-trace/tools/for-next. Is this the
wrong branch?
> 
> Thanks,
> Gabriele
> 

