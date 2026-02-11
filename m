Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83B341056;
	Wed, 11 Feb 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827893; cv=none; b=BszWLT4BILnSMq4IjEJtkUVgNrEXokN0m2hLTf93t+4riDhr/HlNalFlbxvYLHMQyaAsXj/GwOqjj1/OjdIAFvJBMA9GWdiBTF/R9cA8uOlNiIxMfx4Vezo7CPEPjdLS1UfeB6km4J3pq+WB3fUaibrwWfhxJJN7Iou1JaERevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827893; c=relaxed/simple;
	bh=w3YeIuMaLylfzvXWpqdtKcgJOrglIgCtCAL1grwwhtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJm7Tw0GpEJE1gsyTZXs5l8HwtSjgWqKx0GyQEY9SFpMw40ZRJHNCw9P0hI58G4cY3JzrG8MFw9fAjEaB3YJWT+YKX8YXvLOEYODY7OSkmsKX36Vp++2djZ67fMrLAO2uCEDFHApeJ8TbtTWGQHxjr0w6f9RIyRJap5WVXu/Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E06F658B05;
	Wed, 11 Feb 2026 16:38:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 90E9520031;
	Wed, 11 Feb 2026 16:38:03 +0000 (UTC)
Date: Wed, 11 Feb 2026 11:37:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: Fix checking of freed trace_event_file for
 id files
Message-ID: <20260211113752.54bf37e9@fedora>
In-Reply-To: <20260210113427.1068932-3-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
	<20260210113427.1068932-3-petr.pavlu@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 90E9520031
X-Stat-Signature: bosz5adahn6g41ricbcapkztytc6d9z7
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/sA0euCELZ0sjwXoIv03Ql8ey49QR+2/o=
X-HE-Tag: 1770827883-907037
X-HE-Meta: U2FsdGVkX1/nVRIKu1cH0gNhip73uFDTuWb8533g9KZWEXoJ1Z655vgBf/Pq/ReM5+oKPTRdHbsJx51sWLVu0pjq7R32LOE827o+Itjhz2c8sz76rLrn2DXhscykOCH7MfNLysdDmZ0TOPAsCXBr+zIFTM9rN84IYw2Xy3hMOpjDhP0mWxnl5eyiSFDiQxG1fj1Epnvpbaa/5UuiDaEOsq8BcSyqHv5f9F8YaNdf40xMw/ZHMzxqxSajIIQs8/9LQybtK6sYlKdVtOSc2UzsswcPsCjWBVLxIdymPiHUilnIeViK5gbHjbHlKoKExl3eqvAGfeETCIAcIki0XysrrxUItAljZ5nNM44KrkYhzslNtxeaamislghmnAvpLRXb

On Tue, 10 Feb 2026 12:28:17 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> The code for reading an event id currently uses file->f_inode->i_private to
> store the value of trace_event_file->event_call->event.type, unlike all
> other event files which use it to store a pointer to the associated
> trace_event_file data. The event_id_read() function retrieves this id value
> from i_private and checks if it is non-0/NULL to determine whether the
> event is still valid. This approach worked in the past when
> remove_event_file_dir() would set i_private to NULL for all files in an
> event directory upon removal. However, with the introduction of eventfs,
> i_private is assigned when an eventfs inode is allocated and remains set

> throughout its lifetime. As a result, event_id_read() may fail to detect
> that an event is being removed.

Who cares? It's just an id. If the event is being removed, there's
nothing wrong with still returning its id. The code currently is very
simple, I don't want to make it complex for something nobody cares
about.

-- Steve


> 
> Fix this issue by changing the event id file to use i_private to store
> a trace_event_file pointer and utilize event_file_file() to check for the
> EVENT_FILE_FL_FREED flag.

