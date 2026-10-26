Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022300;
	b=44v++jg5x453rZKdWJnh5To7jl2FnAyMf5QNnCQWBhUaWS7L0AKfZoFRl1lPI1U4wxyt
	 ZgLuehd4TEYGdeCQUU3aixJXaXdhIcuUEBtSWbJF8ZimHY7CyUzFAgpbnIb5upumfPebZ
	 uEFO6AXG8NYID/wgabwOAFjxWoUf+vStlDSGCeoken1MgE0K17oiy8csU7tXnNWU0xJsP
	 xnbRlVJ6eguLeElkLkxk0+YaapqJOwnfmuDTgVysxitDhLB3FSl6kYeZubEUOqKXABFAr
	 wrjgbqTXvFSIClbu7WbAGhk6C3Z6/ME8ybFgcVVByu1GZlzyVpufZHNO196HIKJs74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022300;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=eG65rhCNpyJLKGU96gIUFxD719knZ1vO0jygU6hbTRw=;
	b=ZeSKTSLV/phUsCvEmXXVM66cm99MOk7dYZxJKq3CMgt7DBv3MbqCjShmnR/jBdlBthfE
	 K5Wo6HVI0eZGEmTN7x2CyciaYtfivru8EOAwzhhBqHDeRaQ/3no8haPT9mC4dn4npjtH8
	 GLglwS802svs9kLWAmqu9SEQ/skaBAf/N8ef62IwlO09uEB6urfkI7Y4Gw/J9Qdfk8Dk6
	 lZ3W04nTvIljyK/W6PP7TMt6WTxa992omJlILSXgG3TeyNvoE7iMxy1ywd+w1aqNctUo+
	 Y2ozRksVtLutwsXWfEqKi1zUJ98hMRvXBEVr2sIb9v2nkEpdrscVGJEz8wEfr/DcTRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XwVuTAqO;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6839606A31A;
	Mon, 26 Oct 2026 13:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6839606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XwVuTAqO
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C1C77A07AE;
	Mon, 26 Oct 2026 13:44:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id E7F6820027;
	Mon, 26 Oct 2026 13:44:49 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:44:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/10] tracing/filters: Fix event filter parsing and
 matching bugs
Message-ID: <20261026094448.4eb65e73@gandalf.local.home>
In-Reply-To: <179285912318.466249.7425922682086130057.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: ito5bg1q49otoqhtt9priqhe5tigg5wq
X-Rspamd-Queue-Id: E7F6820027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OGu00ge1kP+3n7MwFyIvRXDgr8kpK0gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=eG65rhCNpyJLKGU96gIUFxD719knZ1vO0jygU6hbTRw=; b=XwVuTAqOz9Hq+nqOkN7dfhvT/Ne3bdoAYxoZtS2vY9B+Rk4YVleR9YMeWQgB+94L4J4/3H/vlBpAkvCjn+hI6iehRZUv02ie5qUu8P7QWY6/oHrCKbU+kJVHSUOESvKZLpauc3Wifyf5Pj4n0dJ7N7Mdkwiju1hnj5xY5xc+w2E=
X-HE-Tag: 1793022289-62506
X-HE-Meta: U2FsdGVkX1/3Nj3UrZZDK7v+rx7qWlfY71TAnFkO7QZZQDoy1cijmT4XUw4CD0QlxzyF4EBeIcnlIBTg0GQlXagY3rv00zByuzB1E6cZbbUdB5f2KbGNcgqk67a4iNrDzipMKq4YOAqRjV2OBS8VVD/4FDHwHKRAWShslCH66Tk4QzfCm3OnzHEAg0DGXnjt7LliOwiUHAQ36gAz0CxrKuyVKNOD3pOaZEY7VqKnWEpEIk0qXUU7CpJ/AaQ+Yzd00iOm3wdO2izc0drXP7+dnnossmCw5xoiYZas3rqafLC76fuEgUgXjlXtS9XKSs9AlNmv+ARBkWK4BRS1tfjUEHNfPqXuhABi

On Sun, 25 Oct 2026 01:25:23 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of fixes for various bugs in the trace event filter
> parser and predicate evaluation in kernel/trace/trace_events_filter.c,
> along with a new ftracetest test case covering filter syntax checks.
> 

FYI, even though the Assisted-by tag is considered obsolete, any AI usage
should still be stated in the change log.

-- Steve

P.S. I'm 100% *against* the removal of that tag :-p

(but I wasn't at the Maintainers Summit to argue my case :-( )
