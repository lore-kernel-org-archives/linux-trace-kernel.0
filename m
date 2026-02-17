Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56E3EBF2F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771289682; cv=none; b=uj1YroKHK1ZWIuDoWgEWgt7zuUXvwuwYLGvO8YnNJgmcI2+GMQMY15L7xZObr0+H3WV1RCbHauHL71n/TZROz/6z+eG/Ii0bf+A3Exvs53FvDU+C5R4uyAwMQSdJpWa2fTwuQrwb3pHcjVh/gRueDBatSqoCCnrECtoCN53HVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771289682; c=relaxed/simple;
	bh=xHib8lqOOlCEKP+2ajtevrZdAaPyxYZdGJRGZo3XFg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K19O8GkfQ5XLMm/yKD7WpUIo9txjqyq5G36sOU3MZLiN3T0CZXKxE5GQzxyjcRX7xaNOp94V3emGFvp27WuBlpKprm4HbJWE/BiDRsJUEGxeSD/kXZ9ZL47dkbAP6GQv1plnGiqKKm3HpG8wc4GjUifb4WXvrFZhpWBc/We5Q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 523EA1B5894;
	Tue, 17 Feb 2026 00:54:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 268B818;
	Tue, 17 Feb 2026 00:54:35 +0000 (UTC)
Date: Mon, 16 Feb 2026 19:54:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Thomas Ballasi <tballasi@linux.microsoft.com>,
 akpm@linux-foundation.org, axelrasmussen@google.com, david@kernel.org,
 hannes@cmpxchg.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, mhiramat@kernel.org, mhocko@kernel.org,
 shakeel.butt@linux.dev, weixugc@google.com, yuanchu@google.com,
 zhengqi.arch@bytedance.com
Subject: Re: [PATCH v6 1/3] tracing: Add __event_in_*irq() helpers
Message-ID: <20260216195434.7a8ae4b5@fedora>
In-Reply-To: <20260216161323.4098568-1-usama.arif@linux.dev>
References: <20260213181537.54350-2-tballasi@linux.microsoft.com>
	<20260216161323.4098568-1-usama.arif@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 268B818
X-Stat-Signature: g8ygnbnhshet6yttf3u48am1txnch4gx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/BundDqrqHqq8/xV/gBGT0C+oZI00kiHQ=
X-HE-Tag: 1771289675-796754
X-HE-Meta: U2FsdGVkX1+/rLmJ3XWTiP/Yk6N42IvEIOK+SpVQcyahCo44khKDjZnOUm+bmy6xN7U1xuYaoCMHdcFaiqIUmeDl5jf4mz5Kh0jh9q9BXOk19YUF/Up1AumPf9WJcNQSvy8I2darMzrhhA2UMLvnIfbMepCKO48a2wQNjCLx8OOqWclEunmrDspukGYqAsIxvoFLAbH7Ppz8EI1UjvfghEu7HCyv5YDOIT5Ibvd5E5J/vga+8q++otBXCQ0c/rQ2A8eOO0OtLHbaUfXXgoX1mXR5qtr21Cwt3+Myu7iA10COf17Z2Zp65DhLQ93OV3rS

On Mon, 16 Feb 2026 08:13:21 -0800
Usama Arif <usama.arif@linux.dev> wrote:

> >   TP_printk("val=%d %s", __entry->val, __entry_in_irq() ? "(in-irq)" : "")  
> 
> Should this read __event_in_irq() and not __entry_in_irq()?

Yeah. That's when you should have done "cut-and-paste" but instead just
typed it in by memory :-p

-- Steve
