Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE5265CD3;
	Wed, 23 Apr 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396022; cv=none; b=lcY/UBS+DCBNa/v3xRFSYxwPWo+wAFp14emgUN5Q7x/ygmdyzBSkk5WZ9Z43Wqj/a3No/iyYw0krGh3GPkIyPIsQtLyu7bBhYFillz8A42eSkzbukC03QkOOSZcWn79reVQkNpx1Gan0LYKRAtwijBOVEUjA8mJ5qUI6weSdvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396022; c=relaxed/simple;
	bh=9ydwNJZ1tCDj7oO3s8GSF0DTcFIor64HYDBpPlz490o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9QEzyNJMRNvA6jT8DMUrckrvYNs3fkv/l4+JJKHQALTz/HBZ+81HTPRJO2ACaLYy7CJ/79inuYIPTjjuI0ljI+RBOiRB2pT8W6CMPbadb7/kyv0jDu9sQGbllj7Gfuiz1VTr+NWB2D+fOGCdrV8lZLi7WsDJi49Oi7A7fYya4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E093443A3;
	Wed, 23 Apr 2025 08:13:33 +0000 (UTC)
Message-ID: <4f65d7be-37d2-4646-bfb0-34b78047d4db@ghiti.fr>
Date: Wed, 23 Apr 2025 10:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] kernel: ftrace: export ftrace_sync_ipi
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Andy Chiu <andybnac@gmail.com>,
 linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, palmer@dabbelt.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bjorn@rivosinc.com,
 puranjay12@gmail.com, paul.walmsley@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, eric.lin@sifive.com,
 vicent.chen@sifive.com, zong.li@sifive.com, yongxuan.wang@sifive.com,
 samuel.holland@sifive.com, olivia.chu@sifive.com, c2232430@gmail.com
References: <20250407180838.42877-4-andybnac@gmail.com>
 <202504090657.5fiH4UIS-lkp@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <202504090657.5fiH4UIS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeehtdefffefffdvffejkeduteduheejfeejteelleelveegtefhfedufeeuhfetudenucffohhmrghinhepghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdptddurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemtgeludgrmegtkeehvgemtgduuddtmeekuggvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemtgeludgrmegtkeehvgemtgduuddtmeekuggvvddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemtgeludgrmegtkeehvgemtgduuddtmeekuggvvdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhguhigsnhgrt
 gesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlvgigghhhihhtihesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhtrhgrtggvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Andy,

On 09/04/2025 00:31, kernel test robot wrote:
> Hi Andy,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.15-rc1 next-20250408]
> [cannot apply to trace/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Chiu/riscv-ftrace-factor-out-code-defined-by-WITH_ARG/20250408-025114
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250407180838.42877-4-andybnac%40gmail.com
> patch subject: [PATCH v4 04/12] kernel: ftrace: export ftrace_sync_ipi
> config: xtensa-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250409/202504090657.5fiH4UIS-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504090657.5fiH4UIS-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504090657.5fiH4UIS-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> kernel/trace/ftrace.c:191:6: warning: no previous prototype for 'ftrace_sync_ipi' [-Wmissing-prototypes]
>       191 | void ftrace_sync_ipi(void *data)
>           |      ^~~~~~~~~~~~~~~
>
>
> vim +/ftrace_sync_ipi +191 kernel/trace/ftrace.c
>
>     190	
>   > 191	void ftrace_sync_ipi(void *data)
>     192	{
>     193		/* Probably not needed, but do it anyway */
>     194		smp_rmb();
>     195	}
>     196	
>

I fixed this with the following that I squashed into your patch, no need 
to resend a new series for this.

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0d4eec5747074..30374478cb077 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -635,6 +635,8 @@ enum {
  #define ftrace_get_symaddr(fentry_ip) (0)
  #endif

+void ftrace_sync_ipi(void *data);
+
  #ifdef CONFIG_DYNAMIC_FTRACE

  void ftrace_arch_code_modify_prepare(void);
@@ -807,7 +809,6 @@ extern void ftrace_call(void);
  extern void ftrace_regs_call(void);
  extern void mcount_call(void);

-void ftrace_sync_ipi(void *data);
  void ftrace_modify_all_code(int command);

  #ifndef FTRACE_ADDR


Thanks,

Alex

