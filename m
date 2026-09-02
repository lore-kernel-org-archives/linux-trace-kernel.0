Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD648035F;
	Wed,  2 Sep 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356801; cv=none; b=DzlF4oxrw3Omr+cEL5Ik+fQvzy0D3JhkjP+Kz+I79Xz79i9Zj60fXfR3UaU5maPxBz9oNU5ZDJMM4A/cb322xaSAFqRBJBSEfxPulHn/NKcLv1QEZA3ir5NMxegfRGJpw1gb137opZhvJqJYBOux3tH/cZ0ESOztLxRysdbSJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356801; c=relaxed/simple;
	bh=P2j+lKDQZ1G5aGLG5JoEI2eXCL7Dy1YBHIlPymGrNoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxlZXl2INVY9Jd78CMDjBtuX+AssDfskjY4CCPjvG2ZJ/6JJcUcTfaf3U0/CXzzE7KKlMTDc8fVlhRNRbiE+H2N8Dti40a1lPJETGeX/QaVIKCIqaYcFYPwb3Mkx40Orey4YNOhr/bXHiVjPWK7xqpAXLjrkdhGbgBwP21NSrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=yzaxrYqc; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="yzaxrYqc"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id BD21540202;
	Wed,  2 Sep 2026 13:46:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id D72421B;
	Wed,  2 Sep 2026 13:46:35 +0000 (UTC)
Date: Wed, 2 Sep 2026 09:47:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, oe-kbuild-all@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Take trace_array reference when opening
 options file
Message-ID: <20260902094736.2fcd3d5e@gandalf.local.home>
In-Reply-To: <202609021814.YH14WR0q-lkp@intel.com>
References: <20260901163620.6cbe0ada@gandalf.local.home>
	<202609021814.YH14WR0q-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D72421B
X-Stat-Signature: dshprnfczjbzjc4xdy9s1ky8e933ysma
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19YOE1xz9XKIH0iIdcwPJfH1GpYiFczEew=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PQ4uVyoFqfhmwHdEmgX9n8s1dQPgnO3UwApcxrO8s6w=; b=yzaxrYqcePIS5Dmo9O4NUpkJxVbaLezMebMvUrWI9uzKHHsN+YVUra8nHM3RsUkmTStOkRCOhlP93W7ZHpQxUnAblyneml5di/Nv3h7Bn/s35PWHkxA3wh5MqL47O1sj77g5wqXJK5o6dNa6cmoY4cBorr8EzMG7lEP/EzQPJYE=
X-HE-Tag: 1788356795-802407
X-HE-Meta: U2FsdGVkX19CpEm06zOi2rUcJstNRaxzk9mqigs+f3c8hzlfQGJnvSjHs/ZhNUub1lEvJvzYtMrXf9N5fRU7E9MRLouMvBk6Bw/2z+cp6W80N494WQaR2VekFpRMo7rw62icYljM35DApdupTISxnsx7bYzhrhsHoWd+CuiLrVc9mNnIOt4J+wSturgq/IaohIy7Tp44ZnEloMiY+C2UAi9kW0JzP0cWzHPR75eSIoqbWirkPX/txN/yR6lUM39nsccx6oZEbFphgD6iYpxfi/Q7kyS2CgGmRDzc8ozmMbMgWmDR9NvBXhDWRCEdj9zgEBuT7KX2qlvAF9JfgRdj0YJsKciDIwoM

On Wed, 2 Sep 2026 18:36:45 +0800
kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'trace_array_options_get':
> >> kernel/trace/trace.c:7871:30: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]  
>     7871 |                 if (tr_index >= &tr->trace_flags_index[0] &&
>          |                              ^~
>    kernel/trace/trace.c:7872:30: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>     7872 |                     tr_index < &tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])
>          |                              ^

Hmm, I thought void pointers could compare to anything. Oh well, I'll
typecast the address too.

-- Steve
