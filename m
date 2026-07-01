Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C738758A;
	Wed,  1 Jul 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934028; cv=none; b=e4hzsYLiUHkhLped7KLGLM1Pofc7II7Rpx4HTu4wSHZHIH5BEqElg8hIuWL6qnefwL7NzHO6LKNLRgKq963/ispcfpIZa3ry9L+cPOd4IiWwRUNiy28U7pNDiUfQmDgfmMY+EHBzg7VYwfA10Y7MpNb1MqO/tqr2bTC65DG9PvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934028; c=relaxed/simple;
	bh=3tSZvQZM8u1KT7+KeYOlpz5ulVogL54tBTMWHURWZAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+F698ken37w5UT4E5cVM7rVt1ITPs3a/c4QN2xgTlJIMOqNljQ0LF2m5ca0N03tBuiNFV5ea2NGRN1axH0T9ENA9t2v37JNL6RTWGnxTYKlWIo1WNRmb9l2TcrCaEFD4hPzaQ0QAQdMBRt3uI7Cn4oy+XV9doAH81qYWkVRYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1570D8DFA5;
	Wed,  1 Jul 2026 19:27:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 6E5231E;
	Wed,  1 Jul 2026 19:27:04 +0000 (UTC)
Date: Wed, 1 Jul 2026 15:27:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Wen
 Yang <wen.yang@linux.dev>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH v4 12/13] rv: Fix read_lock scope in per-task DA cleanup
Message-ID: <20260701152705.6dc9d8f2@gandalf.local.home>
In-Reply-To: <20260601153840.124372-13-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
	<20260601153840.124372-13-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6E5231E
X-Stat-Signature: o8a65pspgzkyp4gaeje1ru41t1aayx9g
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Y1CeLMmZ4+r1cpFvs/ph11tozzF5ONyY=
X-HE-Tag: 1782934024-888877
X-HE-Meta: U2FsdGVkX19FfYBm6s2u4X53VtmH0xLjSFU519vYmgi4e590dT85+5Z7EwcjJ/uN8wIRB+I6L9duOoCG00gPlSB23HUKsuJWA+O26bjNSnxHOLN8w1FBho5Fv7yBT1pJgct3Iqo4GrMXO0MR+D/FtSTC20mWBULHRJtZqunOVXK9R7UkoKOy+DuI3nYyVtcN9uP7Q9h866O1BX6J2dI/MM95JXhwRRiPNMODiwODbRhSxaI7U6z+tW71RhLOnwJB4vStyaushC2Uyvt3yQ99rvfYh2OLG7lRqHYcUKag7NWStOggStu8U6ZbdvFCCvKQG8w/ImtmNvrLxppoNT1kTxH0MB07BYXarPajJ4g9z97FD0+RxPk9lE9SGeazLrgC

On Mon,  1 Jun 2026 17:38:39 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> The da_monitor_reset_all() function for per-task monitors takes
> tasklist_lock while iterating over tasks, then keeps it also while
> iterating over idle tasks (one per CPU). The latter is not necessary
> since the lock needs to guard only for_each_process_thread().
> 
> Use a scoped_guard for more compact syntax and adjust the scope only
> where the lock is necessary.
> 
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Hmm, this and patch 13 didn't get applied. Do you plan on sending them later?

-- Steve
