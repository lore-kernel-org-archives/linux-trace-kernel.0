Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E02E336E;
	Wed,  2 Apr 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579325; cv=none; b=dbw7jPrxDTHL5L7x8gWSoB6p3xp8Rp6eAaXERbhiUqmn7r0advNwra+zru6N60QGD9WxyAW5yqS9sShed3JV1WgJCF1dbkhlglMX+F5YYgM9jTSbjseR7wA8GdIlKDnNTNYv2bYCMXtXLDdacgEvb32lTospoT8huzSqtTy6700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579325; c=relaxed/simple;
	bh=Rl6ojrqrap5uQrfVyQbAG30PDzQu9TC9QK6WccioewU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5jlbMGB/9aHKNqWWuLh1fHlNgP/eCNsYqS8fI55mSFLPXgnq04FAa+B6Gt734eifmzp4temjWOw++C+fq9fvyZt6DuyULyKcQXBUPbQcZP/IDz8wtKvA7V7R/rDMQWp2hH6AlZ3ckBh23u8//2KDTlMWctE/xOg3SbyjjSE9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9B57442AD;
	Wed,  2 Apr 2025 07:35:12 +0000 (UTC)
Message-ID: <0c89da8c-10e5-42d2-99cd-557b25a8e91c@ghiti.fr>
Date: Wed, 2 Apr 2025 09:35:12 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] riscv: mm: Add page fault trace points
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, john.ogness@linutronix.de,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
References: <cover.1741708239.git.namcao@linutronix.de>
 <672e2bed604c307c807f546627ba5a9454ef10eb.1741708239.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <672e2bed604c307c807f546627ba5a9454ef10eb.1741708239.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepfedurdefvddrkedurddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdefvddrkedurddukeejpdhhvghloheplgduledvrdduieekrddvuddrfedungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehnrghmtggroheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepghhmohhnrggtohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhtrhgrtggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnu
 higqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 11/03/2025 18:05, Nam Cao wrote:
> Add page fault trace points, which are useful to implement RV monitor that
> watches page faults.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/mm/fault.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 0194324a0c50..04ed6f8acae4 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -20,6 +20,9 @@
>   #include <asm/ptrace.h>
>   #include <asm/tlbflush.h>
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/exceptions.h>
> +
>   #include "../kernel/head.h"
>   
>   static void show_pte(unsigned long addr)
> @@ -291,6 +294,11 @@ void handle_page_fault(struct pt_regs *regs)
>   	if (kprobe_page_fault(regs, cause))
>   		return;
>   
> +	if (user_mode(regs))
> +		trace_page_fault_user(addr, regs, cause);
> +	else
> +		trace_page_fault_kernel(addr, regs, cause);
> +
>   	/*
>   	 * Fault-in kernel-space virtual memory on-demand.
>   	 * The 'reference' page table is init_mm.pgd.


For this riscv part, you can add:

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

