Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC829A2;
	Thu, 23 Oct 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177874; cv=none; b=fl4WiELQek+2MU/0jpTlxKXrKgBeTp7aKHzOjm/7PHW1bEhX2ed4zUHr0/NIM0eNGtCDcIhxGCLNZA0QHQY1O+sVa9EbWS4ugfnhxo3XTgUTeHgpMc41Lp+q0qz0Ck91rTfvcBajXqqGb73AFHyYnBkn04KCCC6QIRoxLmeKlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177874; c=relaxed/simple;
	bh=R7sNaw4y/sEBbeMQ9YD6iGrdQApY+snp9f5pwr/so7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOjz2Y/o/F3waVUuKPLm4BiR2D5HZNXwSaIfJMkCTVuCVu60VdnOYfUQf0CEOoKf+oKrnKuZqQtKsBTyY6zLzIuZGxhUM4Btm+illBD6mtqvq66M/7fom9jj6pCvb3EVebqqAJeeLPUPwmBy/bjz3tkrfPqszwKNMsYhu6uOQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3jBWO5N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3jBWO5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761177873; x=1792713873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7sNaw4y/sEBbeMQ9YD6iGrdQApY+snp9f5pwr/so7s=;
  b=h3jBWO5Nr21elAaaquD9VtwOU0FED2CjuiDurhmd32Enrpu8AstOo+pP
   U0+1MVm566JInYp2z+ICcPe5IgsJhiMf8wScDEjhdIbJhif8Ge/DWpVO5
   R4I5AT7HxW8OB2GJh/o8PXRd6IiryYFX0HLI3W9zTBCMLAlBiuXLI4l39
   dVvFna2TG/pxVPs1W6PIq9m5vjyooD5nKCKemW/N6adNYS38/azgDSB0O
   f0vDTVtsnPsTgFk1tE0VNdvhsY+wZS5+aMiZax9tNm6cnGkJ8HgEZwh5r
   waPmdAJvhBu7wefDj9SKIqKna+joabx71wKZxjazctquFd3qy8hCqvw+w
   A==;
X-CSE-ConnectionGUID: 9p1xJsDKSauBDWIdZXhB9A==
X-CSE-MsgGUID: Gultst/rS2qMsYrifdH/Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63433945"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63433945"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 17:04:32 -0700
X-CSE-ConnectionGUID: RQ5X8IvDSJW+shKWJ/XzaQ==
X-CSE-MsgGUID: SUBhFPknQIWpRfmqleoJzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="183179024"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 22 Oct 2025 17:04:27 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBiob-000CqZ-2B;
	Thu, 23 Oct 2025 00:04:25 +0000
Date: Thu, 23 Oct 2025 08:03:41 +0800
From: kernel test robot <lkp@intel.com>
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Yingchao Deng <yingchao.deng@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, quic_yingdeng@quicinc.com,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
	Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Subject: Re: [PATCH v3] stm: class: Add MIPI OST protocol support
Message-ID: <202510230717.u8tTLt9x-lkp@intel.com>
References: <20251022071834.1658684-1-yingchao.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022071834.1658684-1-yingchao.deng@oss.qualcomm.com>

Hi Yingchao,

kernel test robot noticed the following build errors:

[auto build test ERROR on atorgue-stm32/stm32-next]
[also build test ERROR on linus/master v6.18-rc2 next-20251022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yingchao-Deng/stm-class-Add-MIPI-OST-protocol-support/20251022-152642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20251022071834.1658684-1-yingchao.deng%40oss.qualcomm.com
patch subject: [PATCH v3] stm: class: Add MIPI OST protocol support
config: i386-randconfig-013-20251023 (https://download.01.org/0day-ci/archive/20251023/202510230717.u8tTLt9x-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510230717.u8tTLt9x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510230717.u8tTLt9x-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwtracing/stm/p_ost.c:201:13: error: call to undeclared function 'task_tgid_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     201 |         hdr.tgid        = task_tgid_nr(current);
         |                           ^
   drivers/hwtracing/stm/p_ost.c:172:6: warning: unused variable 'i' [-Wunused-variable]
     172 |         int i;
         |             ^
   1 warning and 1 error generated.


vim +/task_tgid_nr +201 drivers/hwtracing/stm/p_ost.c

   154	
   155	static ssize_t
   156	notrace ost_write(struct stm_data *data, struct stm_output *output,
   157			  unsigned int chan, const char *buf, size_t count,
   158			  struct stm_source_data *source)
   159	{
   160		unsigned int c = output->channel + chan;
   161		unsigned int m = output->master;
   162		const unsigned char nil = 0;
   163		u32 header = DATA_HEADER;
   164		struct trc_hdr {
   165			u16 version;
   166			u16 magic;
   167			u32 cpu;
   168			u64 timestamp;
   169			u64 tgid;
   170		} hdr;
   171		ssize_t sz;
   172		int i;
   173		struct ost_output *op = output->pdrv_private;
   174	
   175		/*
   176		 * Identify the source by entity type.
   177		 * If entity type is not set, return error value.
   178		 */
   179		if (op->node.entity_type)
   180			header |= ost_entity_value[op->node.entity_type];
   181		else
   182			return -EINVAL;
   183	
   184		/*
   185		 * STP framing rules for OST frames:
   186		 *   * the first packet of the OST frame is marked;
   187		 *   * the last packet is a FLAG with timestamped tag.
   188		 */
   189		/* Message layout: HEADER / DATA / TAIL */
   190		/* HEADER */
   191		sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
   192				  4, (u8 *)&header);
   193		if (sz <= 0)
   194			return sz;
   195	
   196		/* DATA */
   197		hdr.version	= STM_MAKE_VERSION(0, 3);
   198		hdr.magic	= STM_HEADER_MAGIC;
   199		hdr.cpu		= raw_smp_processor_id();
   200		hdr.timestamp = sched_clock();
 > 201		hdr.tgid	= task_tgid_nr(current);
   202		sz = stm_data_write(data, m, c, false, &hdr, sizeof(hdr));
   203		if (sz <= 0)
   204			return sz;
   205	
   206		sz = stm_data_write(data, m, c, false, buf, count);
   207	
   208		/* TAIL */
   209		if (sz > 0)
   210			data->packet(data, m, c, STP_PACKET_FLAG,
   211				STP_PACKET_TIMESTAMPED, 0, &nil);
   212	
   213		return sz;
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
