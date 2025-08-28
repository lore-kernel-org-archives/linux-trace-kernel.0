Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E026D4CF;
	Thu, 28 Aug 2025 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349920; cv=none; b=pndyI7R1AnpJmHS4wE2J5u47VRw2Cz39qUxcMXDbIieXt1hlB3HzKXNDdlab1wSxo2yuKUvfwQkaG19mfz2S/THM2+0AysSHFEqauienJdFoadd6T/WV3x+ed0SPoOBLuFRzedy+vOHHhh0H3OO++68m9XedV9Bi0vcWhOj+MqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349920; c=relaxed/simple;
	bh=AeI8h/B67+4lPjYfT73hgXridJPmWx0XGWAvoKdEOKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUazwQii5boRlN+3DLSpIiJKh2znPknQ0Cazh/8m3OIt13rhrWB+Qp3EdZfQ5Wk9kTkuvmfLVxrku3iH4AFkNxcgNcEszWfxFDkklt0Xw/S5I3SJ4JxRkHkQAyRXsYhc8jN1owK5VpR1d66x1iuhQ2PbKorUpCFrLx1VmHpfMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 027AD140996;
	Thu, 28 Aug 2025 02:58:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 32F7D8000F;
	Thu, 28 Aug 2025 02:58:29 +0000 (UTC)
Date: Wed, 27 Aug 2025 22:58:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pu Lehui <pulehui@huawei.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Message-ID: <20250827225848.32f10425@gandalf.local.home>
In-Reply-To: <d759c163-9673-48e5-bd6b-49446511b7e0@huawei.com>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
	<d759c163-9673-48e5-bd6b-49446511b7e0@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kq145uwea4ggibmdgkso1fwzgjrpcamq
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 32F7D8000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/p6tV9D9tyF1CxRuy+svR+fTx12tj1Iv8=
X-HE-Tag: 1756349909-300158
X-HE-Meta: U2FsdGVkX19PFH/TFnfSKe7xKLZOqYmA4H+EH8Bnep9nqOwrxcBPAr7flDBDfA9UZrkls8wEQSdTgARJhXm8OQkqqv3rygSUFCF3QooqoTqrtrtTVvnC/WuJpk8P1R0mRAl006+38kN/kep28467YBIWZrm4viBItw9rBmEso0RFpgClKcrmgBRX1c+5Xf3iejaI6Cd3XEoveSmbcafq1bOQujZuqNh39PZS8evO0j+fmQl6aYDGkX7ObviOlR3dUbjuJ41JsnXDmeaWQf+todmVbgTXcGPWYlAd/K1aKXqacwmCGFyNUlXeB11Cw4tlNlGCH2YXlk8Io3N6iyg2VAAu0Uz3rchMeG3aEN8HE14ryfcyYDahIg==

On Thu, 28 Aug 2025 10:02:54 +0800
Pu Lehui <pulehui@huawei.com> wrote:

> On 2025/8/21 15:17, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> > 
> > When trace_get_user in trace_pid_write parses an only space, the
> > !trace_parser_loaded branch will break with no errno, causing
> > tr->filtered_pids to still be assigned with pid_list, which may trigger
> > potential problems.  
> 
> Gentle ping~
> 
> Hi all, Is this commit looks proper?

It's in the queue to be looked at:

  https://patchwork.kernel.org/project/linux-trace-kernel/list/

-- Steve
