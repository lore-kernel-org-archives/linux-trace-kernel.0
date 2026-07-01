Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2B481A8E;
	Wed,  1 Jul 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911471; cv=none; b=pmwUMemPD6IwIQ5B4F856IlEbG9HD6SjvaSb50svMvKDTpSn/Pa1cUa8h5Ayw6+bhFm0xIp+DsIIJthfCDiCAdtDI+Zj6PikOeFPJ7PKlWVuO9/ef7KMrLQ/u1/Ta67sdpCXLgXHwhgBMyug7tttc67FA4iovncHtUQKDDy7rW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911471; c=relaxed/simple;
	bh=wrUn1pkW77N46zYgZ2lhvLL6ZsiJ0dm7nBBozpj51pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DihC73Aa/27k4R1XCkWP6qeNbJtTbYZEJJhdFXv/5aakXuTaq0udtvZJ7oRRH2uTJTGQbUov/BMxM9z8i7F2BV3f1erhxwPaZrZrNQKd7rFSyijqhwtHSOZE6N6qjl6Ktpu/xkpAUpex5IKmpaFIO5cbJ8Yac/e3+M8bHbFwaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 77E748B135;
	Wed,  1 Jul 2026 13:11:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 26FAE2000F;
	Wed,  1 Jul 2026 13:11:06 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:11:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 4/4] rtla/osnoise: Leverage IPI event filters
 when tracing a subset of CPUs
Message-ID: <20260701091107.2943a03b@gandalf.local.home>
In-Reply-To: <CAP4=nvT5H73ptaBaZ2fWQ+SjJ-c3eEGZbrSefMV6fxqL-va2XA@mail.gmail.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
	<20260617131803.2988989-5-vschneid@redhat.com>
	<CAP4=nvQ_x+LyDBoQWOBB4ERy8OwEp9LQzyLJJMHzYdrZzK4zyw@mail.gmail.com>
	<xhsmhmrwcw2ll.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<CAP4=nvT5H73ptaBaZ2fWQ+SjJ-c3eEGZbrSefMV6fxqL-va2XA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 26FAE2000F
X-Stat-Signature: bhg3zocy1g9ia9hft6qa96raqd8kxfub
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18i7tg9x8gydDY/oYQcHrwJQzjOStGAI7s=
X-HE-Tag: 1782911466-294695
X-HE-Meta: U2FsdGVkX19ouVEwxASN2S+id23wKChO6hYBjfhEVovlB05Cc6ySh0l9GKczh3DUFk+cTwkbDZMAFVkcsp8CZsxOLGBvdCesmE4eE8q9fMe38hPjjG8yus6fPHe4rCyXHhwpptCMNOt5HbgvTVrV0gHg7IOng3oW4o/iUuPkyYBg5LPlz0QWQ/hLidpE9RISya2UIXdTBhCPaf7RxRAuyDsZrI2XKyU/CacNUM9QbB0SbA+XcOFMPm4zDEurh8dEFENlVPHjeU2JM8KqNcyMatIg+uaU/bJr4HmbdKqszj8ISrU4Mx+icLwlvBvp1FEpYE4YsBswIU1UZa1qX2v16qgwzxlt18Wp

On Wed, 1 Jul 2026 08:45:40 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> I double-checked that and you are correct that the docstring says so,
> but it's an error in the docstring. According to the manpage, it
> returns the number of bytes written (i.e. positive on success, not
> zero) [1]:

Note, the man page is considered the source of "truth".

> 
> "RETURN VALUE
> ...
> tracefs_event_file_write() and tracefs_event_file_append() returns
> *the number of bytes written to the system/event file* or negative on
> error."
> 
> The code agrees as well: in tracefs_event_file_write() there's the
> wrong docstring (likely copied from another function) [2]:
> 
> /*
>  * tracefs_event_file_write - write to an event file
>  * ...
>  * Return 0 on success, and -1 on error.

Ug, that's a bug and needs to be fixed.

Thanks for catching this. I need to spend some time to catch up on the user
side of tracing. There's a few new bugzillas and patches I need to apply.

-- Steve


>  */
> int tracefs_event_file_write(struct tracefs_instance *instance,
>     const char *system, const char *event,
>     const char *file, const char *str)
> {
>         ....
>         ret = tracefs_instance_file_write(instance, path, str);
>         free(path);
>         return ret;
> }

