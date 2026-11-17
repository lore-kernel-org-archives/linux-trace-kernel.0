Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923608;
	b=ZuwjsLYTd4g7CsO18t4ik2W/7ubElTcGCj7jY3u/SqAuz16ypvo7jwlW9J8OAcy/me2F
	 VfnA87QFCWwhn9oUxq/462atTfuXXXGRs+pk5FocIK7cjaEWSY/XteILx5bcxPsT5GYOT
	 rVUjE2w0yATabO8ExkbJT6mKa+G0NVA8zgGROCT7Ylareh+PDTvXggzT8joVa+VHgc7Xw
	 qlSdhcoBYGFldKHihEmYUHWUwbbGLhLAaUYnkVt78e/Cl4KcXTIIDwwl7IcFAkwYSy4cJ
	 kcmFXW4HlANv7U2s5kkOJeStLEU7s+V/mv1NVgvgkI9Z1ZPkaOge3nfiOEu9x9WxPkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923608;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=7B+HFG/uo0rXqTIrxZdBFuO2sEUY7dew0bsrnvAF+V4=;
	b=eO0kNDVBjIPy6H37Amlg2teNPx1keqxxsY6RpQm3sPK8o9NZKiM6356htD/WIrSaDOJS
	 p8jt4yA52yx4oUaRpQVyCNb68xuv3TgTM+jw8xsD8MayjzGC5i8ZZmHabsd8MaTjraNdt
	 Lpp4KCzjWyt8jtqTWArvS0SDeO/lmrtO1Ro4QO5apg82LnzAwwiBtHG2LfFhG+Hhhlbld
	 iLmaKUGDQ+RwayrIZ2cF8JHk9P4lHo6JASg2LGv8gdCmR93WaQXZmLQHAYB7AX/aRG554
	 OFWLk/nSheUYWgK5aHheeXOqRisayb4k35KuRnHHJNmcPGFrSvEtmJhXnA+IWev/xCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gTN92v9w;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB1606A329;
	Tue, 17 Nov 2026 13:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEAB1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gTN92v9w
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 13112C03F9;
	Tue, 17 Nov 2026 13:53:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 5FAF430;
	Tue, 17 Nov 2026 13:53:18 +0000 (UTC)
Date: Tue, 17 Nov 2026 08:53:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <20261117085317.4ae87046@gandalf.local.home>
In-Reply-To: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
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
X-Stat-Signature: a16fe9eh5ozgbz593h91miaigkd8yrnu
X-Rspamd-Queue-Id: 5FAF430
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/n7jw1gWFbWF2vwEVkWYe5fzlESBZgxE8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=7B+HFG/uo0rXqTIrxZdBFuO2sEUY7dew0bsrnvAF+V4=; b=gTN92v9wG+/cynMvHkE2TRg5dNcmMG1Yzy40p25NFOJftrPNE7Orr2HEIwmNaHhuVSLjZjTgkdDZ+LFifsMS+cjWEN68peZw437cXQ8Wee8oHF14A2jA15eAqACuzfW1c9XAX3CLMXegkGZwxFNeU6KEeXFRczHztUQgqCUF9Nw=
X-HE-Tag: 1794923598-850448
X-HE-Meta: U2FsdGVkX1+F+BpsbDWn+m1keIOKFKxhbts+AWcW7s/A9UIDNVINO5Dgoj5ycU5S6z6DIIOT/jXxbfchFcu+5lKGlMqOPpHa9vCSL9iJDwUI/KN1ONfcx3ZBYtPYZ50BNjdG9vfTG8R9Kvi0CniQ+mWgBOI5HIpEAHdfpUVVwIZehmhpZN6CuLuQAt4bdhDt/1rhAbVRg/Ufeue67UQtIwNrxLh0zW6xXOuSmG0iqKCPY2imKlhDfU+aQhQ/6BCFuZTQoG+zz3rXq1Cv8hFVErKlO9jJsoQfrFYfxqdltsJqOdaaDwlcZO2op5+qbT82BhnSrNMv+PLaPGq/11XI4Sdu41sr6I4u

On Mon, 16 Nov 2026 14:46:53 -0800
Brian Norris <briannorris@chromium.org> wrote:

> GENERIC_TRACER is not a user-selectable symbol, so it's impossible to
> enable FTRACE_STARTUP_TEST unless one also enables some other symbol
> that 'selects' GENERIC_TRACER for us.

I believe that was the way it was intended. The selftests are to test the
things that select GENERIC_TRACER. Why would we enable tests for something
that isn't enabled?

-- Steve


> 
> This very file also suggests:
> 
>   All tracer options should select GENERIC_TRACER
> 
> So, use 'select', not 'depends on'.
> 
> Fixes: 60a11774b38f ("ftrace: add self-tests")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
