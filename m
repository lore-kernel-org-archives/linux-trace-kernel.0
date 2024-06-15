Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD4182BD;
	Sat, 15 Jun 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718492268; cv=none; b=sj/oBEqscqpm+tayA871/59osvQGr3ZqC+j3cgn205xKHoL/s251B6z4ctRS5NtEYQMyFlq5dRwmnXJdaJrZGF3tHixav0s+LDBrnGHLDb1EAGT04zuadj0d95RghqfQq2eXRiP7W9gosRdbM7bezCsRC3rjUElpBNTrKw9uo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718492268; c=relaxed/simple;
	bh=xGWREnMXr4sgcSPZUNg+qY2W7mkgfv7zvb5EPMvy93M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyw5kiOXeNOes25L9fJGEzIBH1aucpTPV6SJ/ZiVRZB7a3ehWLb6DAbk5cnvJhff2XcFaZAnM0r6PXWC4TPV9PHhqJ+2L7IEtZ5kUhgQPIJPOnywhXxLlqEhN7629KaOsisb3ss4Rrq8DFaZxgYh0t3d8++2NmZDv+qd9sqoFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7YhUIiu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7YhUIiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718492267; x=1750028267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xGWREnMXr4sgcSPZUNg+qY2W7mkgfv7zvb5EPMvy93M=;
  b=J7YhUIiubecmGBI8S7GcLBPkscha4wMPZQF9cg2GqRIyHZU6+oeommxU
   6Xjyo6ggmAMsorQid8/G7rPN3BDK5bKdTKUGSCspjqOHevk3xuDmKrQ0X
   3/xO1t4X0oyqP2qv16B5jjYyJWtDUrMaFoHEuNTTl5XchNyD87apJ6a1I
   dqc8uuulgOhovjnRQwdvpyuVfq+qNvyOeZNoz7RBGalND0fLr1BA5YCGQ
   AroUcFmYehIJ5dmtbulM51WXOVbwapNwgCHS0cexV1cpQ6OHzXRF57x0X
   z+SwmrOGn/nO3ab0SqufTsJyVP4Z4+JsarItIF9KcdFsG0Uf15tM0mnof
   A==;
X-CSE-ConnectionGUID: 0qoMoXqLSN20t0CREOpiUA==
X-CSE-MsgGUID: lb3MH1vqTFuCSKyCwj55ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18279575"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18279575"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 15:57:46 -0700
X-CSE-ConnectionGUID: tQT5lppYTfmW2X/IqdwLEw==
X-CSE-MsgGUID: e3r39IKvSLGNMxgXhoTGkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40697793"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 15:57:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIcL6-0000Zo-1U;
	Sat, 15 Jun 2024 22:57:40 +0000
Date: Sun, 16 Jun 2024 06:56:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	linux@armlinux.org.uk, ardb@kernel.org, yangtiezhu@loongson.cn,
	arnd@arndb.de, kees@kernel.org, rmk+kernel@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] arm: Add KPROBES_ON_FTRACE supported
Message-ID: <202406160646.J89U1UKK-lkp@intel.com>
References: <20240614022318.2600814-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614022318.2600814-1-ruanjinjie@huawei.com>

Hi Jinjie,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/arm-Add-KPROBES_ON_FTRACE-supported/20240614-102440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240614022318.2600814-1-ruanjinjie%40huawei.com
patch subject: [PATCH] arm: Add KPROBES_ON_FTRACE supported
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240616/202406160646.J89U1UKK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406160646.J89U1UKK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406160646.J89U1UKK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_lrc.c:92: warning: "NOP" redefined
      92 | #define NOP(x) (BIT(7) | (x))
         | 
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from include/drm/drm_connector.h:32,
                    from drivers/gpu/drm/i915/display/intel_display_core.h:16,
                    from drivers/gpu/drm/xe/xe_device_types.h:27,
                    from drivers/gpu/drm/xe/xe_vm_types.h:16,
                    from drivers/gpu/drm/xe/xe_bo.h:13,
                    from drivers/gpu/drm/xe/xe_lrc.c:14:
   arch/arm/include/asm/ftrace.h:39: note: this is the location of the previous definition
      39 | #define NOP             0xe28dd004      /* add   sp, sp, #4 */
         | 
--
>> drivers/gpu/drm/xe/xe_pci.c:80: warning: "NOP" redefined
      80 | #define NOP(x)  x
         | 
   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/drm/drm_util.h:36,
                    from drivers/gpu/drm/xe/xe_device.h:12,
                    from drivers/gpu/drm/xe/display/xe_display.h:9,
                    from drivers/gpu/drm/xe/xe_pci.c:18:
   arch/arm/include/asm/ftrace.h:39: note: this is the location of the previous definition
      39 | #define NOP             0xe28dd004      /* add   sp, sp, #4 */
         | 
--
   In file included from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:52,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from drivers/scsi/aacraid/linit.c:32:
>> arch/arm/include/asm/ftrace.h:39:25: error: expected identifier before numeric constant
      39 | #define NOP             0xe28dd004      /* add   sp, sp, #4 */
         |                         ^~~~~~~~~~
   include/scsi/scsi_status.h:19:9: note: in expansion of macro 'NOP'
      19 |         NOP                     = 0x08,
         |         ^~~
   In file included from drivers/scsi/aacraid/linit.c:38:
   include/scsi/scsi_cmnd.h: In function 'scsi_msg_to_host_byte':
>> include/scsi/scsi_cmnd.h:372:14: error: 'TARGET_RESET' undeclared (first use in this function)
     372 |         case TARGET_RESET:
         |              ^~~~~~~~~~~~
   include/scsi/scsi_cmnd.h:372:14: note: each undeclared identifier is reported only once for each function it appears in


vim +39 arch/arm/include/asm/ftrace.h

    24	
    25	/*
    26	 * The compiler emitted profiling hook consists of
    27	 *
    28	 *   PUSH    {LR}
    29	 *   BL	     __gnu_mcount_nc
    30	 *
    31	 * To turn this combined sequence into a NOP, we need to restore the value of
    32	 * SP before the PUSH. Let's use an ADD rather than a POP into LR, as LR is not
    33	 * modified anyway, and reloading LR from memory is highly likely to be less
    34	 * efficient.
    35	 */
    36	#ifdef CONFIG_THUMB2_KERNEL
    37	#define	NOP		0xf10d0d04	/* add.w sp, sp, #4 */
    38	#else
  > 39	#define	NOP		0xe28dd004	/* add   sp, sp, #4 */
    40	#endif
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
