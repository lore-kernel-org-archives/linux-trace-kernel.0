Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFD1448E0;
	Wed,  8 Apr 2026 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612372; cv=none; b=ddbGrPrpQhntNivIaF1kosb+OlsmDhK5j7dkKpK96/H7IbNmCZjU48m3erTH5h084wEi5oNOOrq88f/XXUqaGC/bsbTynUvuuApQAbdajBp3nw0spYcghFmliRl59wRIvUeOSnZpFC/Oo4WpZqt0EYnWEDqipm8t57EIN9gvzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612372; c=relaxed/simple;
	bh=NRdm1ir1VaM4HbG9RUoh+TOm8VmWd/TgMPF++GgtE54=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMEO6Pd6Z1LSb0CxP9Y3VUiolth1FUm2oppNVburTGk4tVCKi2FkLql//SeykAaXNKj4aOJF0co+Lcursn3N2pmoYIZp+6leonXZGRwA+Q0MnsKmvlOL3NABGPj4k/Wdrwm5HzAHIrrIyk+lfiaE8jiipmol/fi6fuM/ysavwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from reply.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAAXwWzKsdVp1jCUDA--.51320S2;
	Wed, 08 Apr 2026 09:39:22 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Wed, 8 Apr 2026 10:15:00 +0800
Message-ID: <20260408101500.1-tracing-hist-reachability-reply-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tom Zanussi <tom.zanussi@linux.intel.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each hist_field_name() call
In-Reply-To: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-1-pengpeng@iscas.ac.cn> <20260401112224.85582-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXwWzKsdVp1jCUDA--.51320S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW5ur4rAFyxuFyUCF45KFg_yoWkKrb_WF
	Z2qas3Cw17JFsakasxJFnxtFZ3WrZ3Gw1kZr1xt347KrWfXFWa9FykJw1xCa4fJrW3Arn0
	kr93Zr1aqrn29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Steve,

Thanks for looking at this.

I believe this path is reachable.

field->system is set when a VAR_REF is created with an event-qualified
reference. The assignment happens in init_var_ref(), which is called
from create_var_ref().

The parser accepts fully qualified references of the form

  system.event.$var

and parse_expr() passes the parsed system/event strings into
create_var_ref(). trace_action_create() also accepts explicitly
qualified action parameters in the same form and passes those strings
into create_var_ref().

This is also documented in Documentation/trace/histogram.rst:

  fully-qualified name is of the form 'system.event_name.$var_name'
  or 'system.event_name.field'.

The path is user-visible because reading back the trigger goes through

  event_hist_trigger_print() -> hist_field_print() -> hist_field_name()

so creating a hist trigger that uses an inter-event variable reference
in fully qualified form is enough to exercise it.

So I don't think this is dead code. If you would prefer a different way
of handling the printed name, I can respin accordingly, but I don't
think the current branch is unreachable.

Thanks,
Pengpeng


