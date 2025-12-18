Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA8302779;
	Thu, 18 Dec 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082864; cv=none; b=cK24fHyToTl189LeRgKzMSS7g3Tb3VQmIKvSmdGWs7D63UXIwYQzsWOh1rV6Zj/9rczAkijH26hsQFa9qqQQ6ZSJb8XFa2+qXtUpLq4pv5mf8uw4ea/eBLuce0bvTyq1gbx7EuAMdKKnNFQ1ko5+NLMNSRArKQWtOltzzYvDUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082864; c=relaxed/simple;
	bh=/Ryvh2QITxLueebuXUP2iRknRfEv8mtrfjRHXUboMjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAGCToDxkc+i/NlL8cgCW5c0lW06drIhXeaCtLQeDczZ6eDFqxj1Rie5sNyHbmVd2XdLDFgC/DQEK5+AD06OJXc2r5EZNg3DKQYrv48XXRVK/gAXNACEJYsZ63NKiO1m+mq6BDLSXYHDIaqDOO9KgiquQtA3XC6LUqy4504jfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5GxlN8e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5GxlN8e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cuje8ig6a28Lg0VJ0Y9qzlYqiEsZ8+FPv/4gTINIB+o=; b=g5GxlN8eJfNAUjHAytyOM1aZwu
	mYAc3Yy/X+EmNtAYTw7Enr9PtgaXJp+gahI8HuQJ0pVmjVhU0rzhAOMueICtKXRWn3kjzBVr9ahTD
	JxmfG4YC6y8LeKqfPJ6QXVv6T5/tZk1KL2d8PaQDFBrd9xQs/sjJn/6X3KdKqKhE/HQeGe1CnkfZz
	hBke2rgLKTDQZ9Ej5mHJ/n3DEUFkqZc+A9eY/3D3oDkv4xhCKdoeEvSPCKR55GWOedqdsbTZ5wb1+
	tZY6FeeiNWXvj5h6xndSGGjsHXwbSc9rMa5i65EsolHrRlTsnMjPtb9Ls/x6WMkYtVClIDbcQ++Aw
	q27KAyBg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWIpG-00000008zgO-2UYL;
	Thu, 18 Dec 2025 18:34:10 +0000
Message-ID: <95f0c65b-15ff-45db-9845-579f7adf4c86@infradead.org>
Date: Thu, 18 Dec 2025 10:34:07 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
To: Steven Rostedt <rostedt@goodmis.org>, Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Leroy <chleroy@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 David Laight <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
 <20251216161316.45b3f19ff0ad482018137189@linux-foundation.org>
 <55ceb7bf-0fe9-4edc-81c2-d51366847eec@infradead.org> <aUN8Hm377C5A0ILX@yury>
 <20251218123349.35339242@gandalf.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251218123349.35339242@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/25 9:33 AM, Steven Rostedt wrote:
> On Wed, 17 Dec 2025 22:59:33 -0500
> Yury Norov <yury.norov@gmail.com> wrote:
> 
>> I deem to drop trace_printk.h from kernel.h - it is more aligned with
>> the idea of unloading the header. The original motivation to keep
>> trace_printk.h in kernel.h was just because a similar printk.h is living
>> there. But after all, this is a purely debugging header, so no need for
>> almost every C file to bear debugging stuff.
> 
> It is a big deal for debugging stuff. A lot of developers debug their code
> with trace_printk(), and do the "shotgun approach", where they cut and
> paste trace_printk()s all over their code in several files. Having to now add:
> 
>   #include <linux/trace_printk.h>
> 
> whenever a trace_printk() is added is going to be a big PITA and slow down
> all debugging efforts.

Eh? Maybe a PITA, but surely not a big one.
Slow down "all debugging efforts?"
Please cut down on the hyperbole.

-- 
~Randy

