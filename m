Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB9D27A;
	Fri,  7 Jun 2024 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790104; cv=none; b=f425aOW5R6PVgxbVlOosCe3l/+mT69aoN6tqcBYT6SC8T7dVZHvVVXOwx7Odv8zfkb/V8M+hku1T99I5ugmOs9RBsNNSJlY4PkTKuXCv74PJXszOfFF93KVTzg8hNwiHIBgRz015O66FmZo5+q+rztVuqsX/0+2CZNrRG/dQL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790104; c=relaxed/simple;
	bh=CSYTB2dVOTn1wxVQwAkOMx1O39MevSRp/szfd1u8ONI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSWWuYGh7YGv124ZS5TAjVnJ2BsP987oN6qxk9P5gFYLx+jAVV6eBQZBCC/bWlI+gaFSJ0O3MxkwW95jtU1mruVAxpJByu8wGlZnfqcIbmlEySSL4DZuHkTN/gzKk+Pi67JCGsB1Q7V1JSQSGLWHhYNMtOpGNBLamJCvVBdSHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=R44bug6F; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="R44bug6F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BTOKnMT5T2ZhEPykgSzSOI+vQfKzqcBhRm9xKY95hq0=; b=R44bug6FEwA67verN95KlbS9di
	Fb8CAXgDV9V6Fo/fnNRkOHDlmWl+/SlxbIJARzGMbsqbqEk5f2xW5Jtp3qWZBBEzokNzzrXzz19qv
	/WE4/VrRKejOXXQjCeYydUF4AJM86CtbacqxXsVq9zkEo/zX0yahufFC3j8avIi7xiRoCCmIe1Y4f
	GNnHt8ZCEBxwrDWv+OmP8c2uLcuFGHUwQEKAbenoum408yBPqLakeLwpm1cJPQ6twJIhJeAGCrX6D
	vd8ce+A19emKZNv1UETrYjdVp9du7jZkI66AmYgnp6sZgQeEWGv/gwnr/BSMxtywxUbqpZMDs1SxU
	i3D7ZbGw==;
Received: from [191.205.188.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sFffp-000eQE-AD; Fri, 07 Jun 2024 21:54:53 +0200
Message-ID: <aa8c49d5-1a51-9256-6327-d47036b343fe@igalia.com>
Date: Fri, 7 Jun 2024 16:54:41 -0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20240606150143.876469296@goodmis.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240606150143.876469296@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 12:01, Steven Rostedt wrote:
> Reserve unspecified location of physical memory from kernel command line
> [...]
> Solution:
> 
> The solution I have come up with is to introduce a new "reserve_mem=" kernel
> command line. This parameter takes the following format:
> 
>   reserve_mem=nn:align:label
> 
> Where nn is the size of memory to reserve, the align is the alignment of
> that memory, and label is the way for other sub-systems to find that memory.
> This way the kernel command line could have:
> 
>   reserve_mem=12M:4096:oops   ramoops.mem_name=oops
> 
> At boot up, the kernel will search for 12 megabytes in usable memory regions
> with an alignment of 4096. It will start at the highest regions and work its
> way down (for those old devices that want access to lower address DMA). When
> it finds a region, it will save it off in a small table and mark it with the
> "oops" label. Then the pstore ramoops sub-system could ask for that memory
> and location, and it will map itself there.
> 
> This prototype allows for 8 different mappings (which may be overkill, 4 is
> probably plenty) with 16 byte size to store the label.
> 
> I have tested this and it works for us to solve the above problem. We can
> update the kernel and command line and increase the size of pstore without
> needing to update the firmware, or knowing every memory layout of each
> board. I only tested this locally, it has not been tested in the field.
> 

Hi Steve, first of all, thanks for this work! This is much appreciated.
The kdumpst tooling (Arch Linux) makes use of pstore when available, and
the recommendation so far was to reserve memory somehow, like "mem=" or
use kdump instead, if no free RAM area was available.

With your solution, things get way more "elegant". Also, I think we all
know pstore is not 100% reliable, specially the RAM backend due to
already mentioned reasons (like FW memory retraining, ECC memory, etc),
but it's great we have a mechanism to **try it**. If it works, awesome -
for statistical analysis, this is very useful; pstore has been used with
success in the Steam Deck, for example.

With all that said, I've tested your patches on top of 6.10-rc2 in 2
qemu VMs (one running legacy BIOS - seabios - and the other UEFI - using
ovmf) and on Steam Deck, and it's working flawlessly. I've tested only
using ramoops as module.

Some code review in the patches themselves (like a missing
EXPORT_SYMBOL_GPL), but all in all, that's a great addition! Feel free
to add my:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks,


Guilherme
