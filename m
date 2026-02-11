Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEE21ABB1;
	Wed, 11 Feb 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828359; cv=none; b=jR225nQXVmnj/9wMLcoY/KOgAG4/b1yOhVx0ycwWTVy+9DoFd09nzi/Uz4RVylnVfxgdEOpybuV+Bte2MSCmzNyD/I1oZOyghmDqXkuygN8Zq1MaJ0UeTy0QXFSem2Jy1WCnC8dzX4DIhaFmjtRix/ySq0Z25gO25yN6nHYkEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828359; c=relaxed/simple;
	bh=VSoRcMmZ2rTzxWCH9jORoY1o87n9ozjwRHnAKrVVPIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bD0ZDOyVBfQ6Tu7nwJilytno+qkD7+LYOLywSju5Y35NL4hHreqP8A52c6YxFSNsGg3vo7OEuDU5mGn0aj1T61+kcWO9UPgfIVN33fAcBhcbACIvHwlLIbu/1Al94ON32LWs1jww7QODefGAsdS+09l6zCJLXF998tmEb58fkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 466241B3C13;
	Wed, 11 Feb 2026 16:45:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 341966000C;
	Wed, 11 Feb 2026 16:45:49 +0000 (UTC)
Date: Wed, 11 Feb 2026 11:45:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] tracing: Clean up access to trace_event_file from a
 file pointer
Message-ID: <20260211114538.577122c8@fedora>
In-Reply-To: <20260210113427.1068932-5-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
	<20260210113427.1068932-5-petr.pavlu@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 341966000C
X-Stat-Signature: 3mwf8yhh5n4p6ru3j664dcdgwsd8qq9w
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/I3Gwm3jZ2hjNeIaKdfo+GxNknXvKlfk0=
X-HE-Tag: 1770828349-332871
X-HE-Meta: U2FsdGVkX1+oC08OiT1eiMaqdZUEeqbWnVD9MVXlnkCEFEhig687ONu5xKe7FWPKi2mE03kYJ987igOrzq7FC13BODwkSNJlOx7JvNjN8zH8obgiq6ql11SsSCvzRe1dqGPPqVVFx+BtvBzz+64bOYGkqIHu3b4kswdSx94+GC4fHn/jf43yV+a/B1zRtNrSxDPNtuJyehPb4ygAreWTfb8EWWeL5OJAOGq26kXhkbkS7lPOXQW99QsKJJAJjJ+oKIkY+S4Fru2Kdlu1cN1cbyOtywI+gqqOq0V1rGskUUETDAJ1EPhXhKs0kZzHhxgj4j/TXJK1O8z/L6+97N6V9Ya+t/mkWkeYBKPz9x1YryNc6zysRRi5H/5MMyfioxG66ocE2Ev232fyBOR9+7PHEFYwLn55gNEP

On Tue, 10 Feb 2026 12:28:19 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> In the past, when removing an event directory in remove_event_file_dir(),
> the code set i_private to NULL for all event files and readers were
> expected to check for this state to recognize that the event is being
> removed. In the case of event_id_read(), the value was read using
> event_file_data() without acquiring the event_mutex. This required
> event_file_data() to use READ_ONCE() when retrieving the i_private data.

I'm OK with this change. Instead of removing the event_file_data() like
you did from event_id_read(), just open code it there. The id is
simple, let's keep it that way.

That is, something like:

	int id = (long)READ_ONCE(file_inode(filp)->i_private);

Feel free to add comments to explain it.

Thanks,

-- Steve
