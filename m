Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A23218BA;
	Thu, 16 Apr 2026 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326680; cv=none; b=T0Pfr2Vi8amMUR4/MGAylduBzEcx4Dn/4ZceAsrufzbtA1O/cexdjOZ326Sja5WyRSXgDhX9XGkwyIagNjnOEW9uGLWTA4LF0wESHQUkoM/v9wkDmmFFD7rDymc37DsQrK7dnjjoFQTVzjUXLdSCzJWHgdawj71Yf4HLRbX1CKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326680; c=relaxed/simple;
	bh=+0O8Ayw2ZurAToBXVK1yDsuQCm9qggvHVzPSdPtRQ+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-ID; b=D3Ssom4ZhrANN3CjZL9PBRLE3w8vcqE/cQbpOgbagv8Hoo9Ncej8mMqEwlhkjW+QDh/pbO5in3sVN02vkPqjDNitfeCjwZ2neQaEf2l0eRH9+/PExzk7Gfky50JjVbhA8B2Pb3Tfykm0X7ewfK6veoL5yMRxLmx+nhhXTM/yBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cj87wamy; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cj87wamy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Content-Type:Date:Message-ID; bh=+0
	O8Ayw2ZurAToBXVK1yDsuQCm9qggvHVzPSdPtRQ+4=; b=cj87wamyk5yxNjGjKT
	kPSg8dLITprbzntr1FCXgL378SZeNg4pZ05tW4CjeOrMe0AT1P+EODAACjDFWLpx
	rT3cCB51+Eu8nRk9vkmGTZjg40rehPsYyDT1hPwbO0HblJR6A8qg6Y+pMiMb8A2V
	hIMH50oRrQzTUEf/dLlZdEilA=
Received: from 229.199.16.172.in-addr.arpa (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBX0y_Yl+BpIwD5AA--.122S2;
	Thu, 16 Apr 2026 16:03:40 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: separate module tracepoint strings from
 trace_printk formats
In-Reply-To: <65f9ebb2-3d3f-4bf4-9c33-2f3855ed008e@suse.com>
References: <41e81533-0fd6-49f5-b7c1-b4e172affd2a@suse.com>
 <20260413123359.32517-1-create0818@163.com>
 <65f9ebb2-3d3f-4bf4-9c33-2f3855ed008e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Thu, 16 Apr 2026 16:03:35 +0800
Message-ID: <177632661591.74561.2238651621364328168@163.com>
X-CM-TRANSID:PygvCgBX0y_Yl+BpIwD5AA--.122S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWkAw43ArWkCr4UXrW8JFb_yoW8XF17pa
	ySk3Z5twsrAFyvvF4kWwsFv345u3yrC3y5Zr93Jryxuw45Xry2kF17twn0vF97CrykZ342
	gr4I9r98CFWkAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2D7-UUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6Byv6Gngl9ygigAA3b
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Hi Petr,

Sorry for the noise.

The previous revisions were not sent automatically by an AI agent, but I
did use AI assistance while working on this thread and I should have
disclosed that according to Documentation/process/coding-assistants.rst.
More importantly, I should have slowed down and answered the design
questions first instead of posting another implementation so quickly.

After going back through the bug report, the code, and a local
reproducer, I think the original bug report is valid: module
tracepoint_string() entries do not currently show up in printk_formats.

The implementation gap seems to be that the module path handles
__trace_printk_fmt, but there is no equivalent handling for a module's
__tracepoint_str entries, so printk_formats has no module-side source
from which to enumerate them.

What I got wrong in the previous versions was the direction of the fix.
I treated the missing module __tracepoint_str handling as if it should
reuse the module trace_printk storage model, which made the mapping
persist beyond module unload. I agree that this is not the right
lifetime semantics for tracepoint_string().

So I do not plan to send another patch revision until the intended
module lifetime behavior is clear. At this point, the direction that
seems right to me is to make module tracepoint_string() mappings visible
while the module is alive, without simply reusing the trace_printk
persistence model.

Thanks,
Cao

Assisted-by: Codex:GPT-5.4

