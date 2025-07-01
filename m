Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C7230BE4;
	Tue,  1 Jul 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407119; cv=none; b=rRJMOVGKM2Rod054dxbIt8SLwsfdo6O+DPTsy6JzhTRskc/IDEBMNYLas3E0v7InLCOcZd6VQnKkRdGuVnDezUwS/CsFn27sYJG2yq3J55eJ4E+hfqO/iCuezP+qcPGdVSctj1fODD2/ap50wg+dUaRRzjbitboY+SqZzax1O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407119; c=relaxed/simple;
	bh=Gd7h7V4tZUgx/tp/sk3Qd8v2RvWILzZB8Eff/zz4YZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2ncaaNn8n0nMkPVVoph0EhhU9ckodnRE6cxm0+RqxdkHTR7MGsSXeGOoc4RTq03GfHCaYLhK4tcerjssaMfR2T+dO0Tr2QficiGtRdOnEFde0sGbqFMEpsCPi0HONSc6Gu1rDwdJCqQYqXmid1+VhAFcMURf7kJWcz8PIfOhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0A9AAC0636;
	Tue,  1 Jul 2025 21:58:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 24A4C20030;
	Tue,  1 Jul 2025 21:58:27 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:58:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 acarmina@redhat.com, chuck.wolber@boeing.com
Subject: Re: [RFC PATCH 1/2] tracing: fixes of ftrace_enable_fops
Message-ID: <20250701175826.429a7b4b@batman.local.home>
In-Reply-To: <CA+wEVJaQcHdpVc3Za8qy0+Z-CGNeaDTrXtjJg2j7J6qsW4uAkQ@mail.gmail.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
	<20250612104349.5047-2-gpaoloni@redhat.com>
	<20250613114527.7e27a9a0ecc2b59d98677b0c@kernel.org>
	<CA+wEVJa0jL-JH_4=5sR+Mvb26n4mPPudmOL0LRBDV54nMZcw8g@mail.gmail.com>
	<20250620183503.6c84eb22cca206cd10418c04@kernel.org>
	<CA+wEVJaQcHdpVc3Za8qy0+Z-CGNeaDTrXtjJg2j7J6qsW4uAkQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xsr3n6d733jgjkmmfciss1nb8euuoupd
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 24A4C20030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+l/RQALv1HGE4aDzquDMpry/1Cchsc5q0=
X-HE-Tag: 1751407107-332310
X-HE-Meta: U2FsdGVkX1+ODILg/f0VuTzk7kNGIH/z+A3/7X+kaAtzbsqbVhRIGSqpb8avD5REDBlmQ2wUkIf1CAXuOJxqC1fkg8BBgLE2hNvKhsUl2lC/9O5A2g9YDHyuiLb8fespd3oqCr04jD4E0udf5smTgoBdSEvFIZuCkEuZ7PQ2q5zcOS3vOPQsdYpFLoFlzE3LqzA1ECf9zoIt1/CI2abBolG5pYQSh4ic7eanoys73bn4MUaiMDBdd310qoBoEmBTodZLWy0SMZrR9wwWfZamEiU4QiXEwm5pY0IqPWCrK7Q26rDRHQjBkVFK941/O1cP+yDeoIqu1k4dfW0hQ+vLZccqk3O0v5dI

On Fri, 20 Jun 2025 15:26:27 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> I think that from my side I do not have comprehensive answers to all your
> questions (I need to read the code more in depth).
> So to be pragmatic I can split this effort into two parts (documentation and
> redesign); I will propose documentation first with the TIPs that you mentioned
> above and later, if we find a better re-design solution, we can also amend
> the documentation as needed.

Just to confirm, I agree with Masami. The enable file is quite special,
and I don't see the use of user space playing tricks with it, which
even includes lseek. Maybe to keep rewinding a read to get a new status
change?

But it usually contains a single character (sometimes two) and a new
line. It's not something that's ever been reported as an issue. I
rather not touch it if it hasn't been reported as broken because
there's some hypothetical use case that can see it as broken.

Documenting its current behavior is perfectly fine with me.

-- Steve
