Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9C1D7E42;
	Tue,  6 Jan 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712603; cv=none; b=S8piTkopCKqK6JFFTvgaI6GyjHC2ItZUdiKvmjvq31iiHgOnUP7oy4r12XDCUBdzvShRtD4RnzQecVrchkuc96mBNBWYrq9DnWLgp51CfAcf29IbS/vnC6t4Cd5CCrIKS30zL/uSabwMx7HRUpaID8YYT1sL3WFtM77XA6nIi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712603; c=relaxed/simple;
	bh=qc//LZgz1lF+f0xjSV9IkpQmWKpZG4SshlTpw8UpVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyUVFGFsSG8dPcmj7I15ecZEoM8gKfCxxRiHWMVDNr8x43tQIzbSKEeA/IxHgNioOMvz8TyzkYmFgjwgUuO1ReIR06untYgIJfSOwUwQGjPKoEjfor4tQpbwv5233jJXD3bEUJt4LIsLI4Gn0K67saKE5VnMiO7DZ+r+0LPokFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4593F57F3E;
	Tue,  6 Jan 2026 15:16:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id E13EB30;
	Tue,  6 Jan 2026 15:16:36 +0000 (UTC)
Date: Tue, 6 Jan 2026 10:17:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 neelx@suse.com, sean@ashe.io, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] tracing: Add show_event_triggers to expose
 active event triggers
Message-ID: <20260106101701.7dd20845@gandalf.local.home>
In-Reply-To: <95feb439-2298-4539-8833-e05ed06f273b@infradead.org>
References: <20260105142939.2655342-1-atomlin@atomlin.com>
	<20260105142939.2655342-3-atomlin@atomlin.com>
	<95feb439-2298-4539-8833-e05ed06f273b@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E13EB30
X-Stat-Signature: s3e15jnw94of4w7jhadcpesz1rb1aut5
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186mq6Wn+0QY+EZwM5Ry6L7xG9jxaYHSVs=
X-HE-Tag: 1767712596-352249
X-HE-Meta: U2FsdGVkX19WRVhj3ndkqb0jEIi5/BnUpscvIwLPesQUB0u1qe+xE7c59/HIMHGoumZo7R+qKxD5hcOWixvq1Wyab0hKZHWwwR+dC6RqUlxtzBm4/SN5rsq9gpXlT+to/lCs0IstJrsowE/GNLeYFnoBKZ+uuUafWSm5CSIG1XEG/sWZwdgRpeRpowJEY3Nc4AkZKJYMVtjhUp2WVNPSg6DAGFrlj/3UoEv61ijIkRvgbxvcTBsPfzqkga9WoINHph4UMpcXkzzO3y0nEZ8UUzC0rikBlBIbHnDT7h5k2R4u7A/huEsUOSf5gYYs78eKZr8DIVm7gFGOSkl/SB3n3+m4SVxMbR7JTeHN5zZkqJ+2/56bd9/OxEUcqhlZenO4

On Mon, 5 Jan 2026 22:10:39 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 1/5/26 6:29 AM, Aaron Tomlin wrote:
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 4ce01e726b09..b9efb148a5c2 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -692,6 +692,14 @@ of ftrace. Here is a list of some of the key files:
> >  
> >  	See events.rst for more information.
> >  
> > +  show_event_triggers:
> > +
> > +	A list of events that have triggers. This shows the
> > +	system/event pair along with the trigger that is attached to
> > +	the event.
> > +
> > +	See events.rst for more information.
> > +  
> 
> Isn't this the same chunk that was in patch 1/2?

No, patch 1/2 has:

@@ -684,6 +684,14 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.rst for more information.
 
+  show_event_filters:
+
+	A list of events that have filters. This shows the
+	system/event pair along with the filter that is attached to
+	the event.
+
+	See events.rst for more information.
+
   available_events:


It is simply a s/filter/trigger/g difference though.

-- Steve
