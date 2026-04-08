Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E92EBBA9;
	Wed,  8 Apr 2026 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614407; cv=none; b=CClrtaStRdEmatq0sF3cZOqNlMwsqBob5hiJABmY00cH7/AinMk5Nva6ErGogEBKPNN9n8SsgPHEsOrtqrnCB6ehdCp7qd8a6L4NNboKzzHTC10ikCoZetw5cguk5PAwscFGJFxAhtzD0YbVOKgkkmRUjDzx+2ro2NQAAwArCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614407; c=relaxed/simple;
	bh=BUWd4Pkdr/VZ3J3Hc+of4N0wwIWMVZrZaA8S2sS/YsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huKfRARY+metuLmUfBdRF/Em8/m6SjurjMEd55PKdwW2c7m74DUS9cvEt1Ut8duPKn43zl6cY3/Fq/RIheLPoP7mdhFNLMRUBO8aC22vYIYomxo832gI1WPYgoRZCrHqA7Tw+vBaJr/H9uk/WHgO/peyRyyu1G9qjTbs4vEw7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id BCC3D5BD13;
	Wed,  8 Apr 2026 02:13:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id DE09080012;
	Wed,  8 Apr 2026 02:13:22 +0000 (UTC)
Date: Tue, 7 Apr 2026 22:14:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
Message-ID: <20260407221437.786b42f7@gandalf.local.home>
In-Reply-To: <20260408101500.1-tracing-hist-reachability-reply-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
	<20260401112224.85582-1-pengpeng@iscas.ac.cn>
	<20260408101500.1-tracing-hist-reachability-reply-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7ua78i65ng6m7xyqape3o1jknazfs8x7
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DE09080012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/u6ec8ZlcsXasoW3W3Sj4itW2JK48i4r0=
X-HE-Tag: 1775614402-888767
X-HE-Meta: U2FsdGVkX19B8oa3pBIYX8O+tS9HGxblgezriBpEaCPjUyIYxfg4awsr3Qg6hB9oQ17K5wd1/amZhEZOIPw7Cp58736QvdBhgzVKAb17wW8CG8/G30a4NizcZX0LjxCiuJ+F7sfyWh/yRaPiio1UJRAHT7G23i6zqB+z1Z+Y6rhWDgQ9NdioW8RSD0auNlc68SJ9dmpQ7sQhLI9/kfaWUcMg6nEy8QLYIV1+5o80hoysnsRzDlulac8DnldPjytwajLq7GEPzzbcCxQE2Pydji1TEbTpzjK8JwW53ERnDU604c6CU91KLSI8yJmMZEsn

On Wed, 8 Apr 2026 10:15:00 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> Hi Steve,
> 
> Thanks for looking at this.
> 
> I believe this path is reachable.
> 
> field->system is set when a VAR_REF is created with an event-qualified
> reference. The assignment happens in init_var_ref(), which is called
> from create_var_ref().
> 
> The parser accepts fully qualified references of the form
> 
>   system.event.$var
> 
> and parse_expr() passes the parsed system/event strings into
> create_var_ref(). trace_action_create() also accepts explicitly
> qualified action parameters in the same form and passes those strings
> into create_var_ref().
> 
> This is also documented in Documentation/trace/histogram.rst:
> 
>   fully-qualified name is of the form 'system.event_name.$var_name'
>   or 'system.event_name.field'.

Ah I read the document and missed this part. Thanks for pointing it out.

None of our tests use this, so that definitely needs to be fixed.

OK, yeah I can trigger that path now. I'll continue looking at the patch.

Thanks,

-- Steve


> 
> The path is user-visible because reading back the trigger goes through
> 
>   event_hist_trigger_print() -> hist_field_print() -> hist_field_name()
> 
> so creating a hist trigger that uses an inter-event variable reference
> in fully qualified form is enough to exercise it.
> 
> So I don't think this is dead code. If you would prefer a different way
> of handling the printed name, I can respin accordingly, but I don't
> think the current branch is unreachable.
> 
> Thanks,
> Pengpeng
> 

