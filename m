Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8E3FA5E9;
	Tue, 13 Oct 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902688; cv=none; b=REdLHf9tI+gZ2y8l/eYQfkvC5Dil3MGUt/eUQk+LiumBpiDHPtu0iUle4BHHBX+vg31SWArWsR15RCman14Tkb60mmYY1IQorTx4seeGJSBBU5EC9AfsJdueuYCenObzrju1nNKJg3jTzuacVfA0GTVE2HCbWUbbQPwsfXK1Wkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902688; c=relaxed/simple;
	bh=m61oaf9UoarRpe2FqD4s+TBjlG4ccC0dVpWN5TR1Nrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqI9Wxx39KeOywUGmKWgmJgltmRRxmP5suhRVBuo4EyXNBs4dmcinc/2/fhHl9esEoDUd72JB5XyvMbouJMUGvhhBMtDoi6fFB+uWfd7wDjWpaZJjCX044pvQOXJ4+bu1unAL30M0F7CUVTXVCIUbdv8LGD1KJndEbZGiKUN3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=m1eGMbm8; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="m1eGMbm8"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A7F231C3CD9;
	Tue, 13 Oct 2026 14:44:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id E430E32;
	Tue, 13 Oct 2026 14:44:43 +0000 (UTC)
Date: Tue, 13 Oct 2026 10:44:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use assign_bit() where applicable
Message-ID: <20261013104443.414b4cde@gandalf.local.home>
In-Reply-To: <arDPNx/dR0ppjSEK@shlinux89>
References: <20260920022810.3145921-1-peng.fan@oss.nxp.com>
	<20260920072151.40637efd@fedora>
	<arDPNx/dR0ppjSEK@shlinux89>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7unggnueq5fat4b4ncxnjgtnsrjm8zhg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E430E32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kU2tkGAassHz66ul2mtkt/Fsod05uv/c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TPhkPWSaDD1/McdEJJPf2CnAdQ+2yZHfMBVkCljFEWs=; b=m1eGMbm8gSOn+sWNopXh3P9OutfY4PgKI1X7gEtXsalxhjm5j59D3cYbZScA9eftf1/oDdnTuwRcqzfW5dTnaG6fmSzkn1Ms8ZJ66ZidXpISIYoMalRXzgqu5Xk6D8pQdWNT7qJO6oyg4L7ltydmbSzFrSP/iGUguN84aq7TGg4=
X-HE-Tag: 1791902683-576225
X-HE-Meta: U2FsdGVkX1/rZs64mw753Zg2xiW16aG6qyPiIp30URAkcUICtXdwmBiQ0S8JJUK+w+qJz3tfUphZebDYx0BEUFVQ2UqLgDb1UAmHFPM7XHoZ+QmN5zMOKIfAazV/g00AuPLT2EAw4o+jpH7RZgA65+XCHwAgMRPXSYEP8p5T8vPsqAGFGSW8DUUpR0qZehS+9OFO3jLNBSdjwJXgXaAIll7P7xsKECDaDQ7QBGqq8EHLxm6mqKZs7HYHId0WkY5/oomvjnqOsfZGa1ShKzRmX1zotHQOZfBBklpeZ3iQlJqhciilkmd6PrQaWOCrrvQxq+MD50qebzfCxXJrzQ+cbwZBUXDJk9hUTnWgtOSveD9H+n6f3q+Uh6iUlrCt/VPd


Sorry for the way late reply. I stopped being an upstream maintainer while
traveling. I'm just catching up now.

On Mon, 21 Sep 2026 14:31:19 +0800
Peng Fan <peng.fan@oss.nxp.com> wrote:

> On Sun, Sep 20, 2026 at 07:21:51AM -0400, Steven Rostedt wrote:
> >On Sun, 20 Sep 2026 10:28:10 +0800
> >"Peng Fan (OSS)" <peng.fan@oss.nxp.com> wrote:
> >  
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> Convert open-coded if/else with set_bit/clear_bit the assign_bit API.
> >> 
> >> Done with Coccinelle semantic patch:
> >>  /**
> >> @@ -1673,10 +1670,8 @@ event_enable_trigger(struct event_trigger_data *data,
> >>  {
> >>  	struct enable_trigger_data *enable_data = data->private_data;
> >>  
> >> -	if (enable_data->enable)
> >> -		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
> >> -	else
> >> -		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
> >> +	assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags,
> >> +		   !enable_data->enable);  
> >
> >Ditto.  
> 
> This will exceeds 100 columns. Should I keep as it is using two lines?
> 
> WARNING: line length of 101 exceeds 100 columns
> #116: FILE: kernel/trace/trace_events_trigger.c:1673:
> +       assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags, !enable_data->enable);
> 

Yeah, if it breaks the 100 characters, then you can do a line break.

Thanks,

-- Steve
