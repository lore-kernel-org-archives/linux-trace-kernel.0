Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090340;
	b=4GMlENfmkEcOjbv0fFl4YZUf5720KMPhHUY4cSboo8Lmb4iVGioU0O+7D5FmvnuSdFk9
	 XLKGWVUbVEYZpDgRywm8VTohFqwUjs1YtuNAZSkCYyFpBA89Y0C1pBIflNnGQ88280p6Q
	 Lu7wauQQ9gw/YpxqIGwCw7yKGe2tvwNKrFTS/E62uMCaEl9z86LGsvr7pun9HkC+nkVOD
	 LncUonOnCcJiusbtg4SpD7HqZ5my2z82ZjHOGwBP236sWEaSVLS2W8OP32x2UPBCGqWvY
	 JK5RYi96GxQVzPmeaF/g/2MI5ZDnZDUFlMpKgoCnJakdw9bj92TRwCYdVRhYDRYeoeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090340;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=54Y4ecze88dJ+VUmulk5r9qxRmugtiqy7i59RBM6cro=;
	b=VCQ3HCRfAuxJ1/Hb+dd5Fb3nwYSsjMPK5OE2UZhnaUSEAVVDOO/SWsX6jrcVXbYvc9HS
	 a2MaAevm1ss0VpqUo/iJHqLZqQXzrFh3Cd5nE5ewwTeLzHyUkJLSJJaRgcJIRc/WRwipb
	 mcKiN7DWCtcy9gKC2hn0KyEoTA/uactEBaSEE01oO7T2iQsgawLkL8ybb5WoNszgsrRfD
	 q6SrXeMJnF1z2tDSJHhRqYesFcTBIHG75FGd6RfWR8xErYDFaaUUgX12lMaIcLDAWW61S
	 PQ0RwZywZxwTbWruply2RfhB5Iea///Y/SPQhln8ND+h2bKD0ZmajnNiIDa1RuaaWaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7QBCr4d;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9A606A32F;
	Thu, 19 Nov 2026 12:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E9A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7QBCr4d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795090341; x=1826626341;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yzKRHGdYy3i0l2rFeJCfddhxcVB8qBD49ukJulLf7Wg=;
  b=M7QBCr4dC5lzOg8R+8ubG/8DcIMThQZe3+P7Y+eczQpVmaIQo3sn5oTi
   QOZtI38udVU9fmDA2NSv3vJDXOsLSuSXqOq+bXR+LUXTT4muef5C6vdQS
   xKRE7mWdgFw+KdB9Wjn8dWWQwT8crEsmvAqNJ7DCvqDqCk/RRbDz5ydEh
   E3o2tMjpAQO0vR1pfoSZPRMRCfgKPhgSMfrMiIjOnOm4m5vbUhPTCY3Vj
   T0DTicO/lR2rw6AnaQiocnULJw9ToJJKX4S8KTRUhnYCkoqSR/BKWOCSy
   aKS2RaogEwajgNEzhC4ZBZAHgL5wWiemjqOilkTU0AyFL8JnHad401bxX
   g==;
X-CSE-ConnectionGUID: r7nfQ2nmS3u+s5ly5oY84Q==
X-CSE-MsgGUID: ze6vpmhkRW2Um7TYaVs2LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3826769"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3826769"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:12:20 -0800
X-CSE-ConnectionGUID: J1wTducRTS+oN5FaO6p6pg==
X-CSE-MsgGUID: sDOhBMfBQh2yA4cF5Svhmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10329030"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:12:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 14:12:09 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    ashok.raj.linux@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 16/17] platform/x86/intel/ifs: Update IFS
 documentation
In-Reply-To: <20261118193259.519568-17-ehab.ababneh@intel.com>
Message-ID: <28f3b7a5-aea5-3298-63a3-cf1e7290e5de@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-17-ehab.ababneh@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Ehab Ababneh wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> Update the simultaneous IFS testing domain in the IFS documentation from
> a core to a group that shares the same SCAN engine, which works for both
> the traditional Hyper-Threading (HT) systems and the Dual-Core Module (DCM)
> based systems (e.g., Diamond Rapids).
> 
> Add documentation for the new sysfs interfaces {status, details,
> addnl_details, cpus_ran}_list.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h | 66 ++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 10eea2c6b871..46461cc69f94 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -14,11 +14,11 @@
>   * Introduction
>   * ------------
>   *
> - * In Field Scan (IFS) is a hardware feature to run circuit level tests on
> - * a CPU core to detect problems that are not caught by parity or ECC checks.
> - * Future CPUs will support more than one type of test which will show up
> - * with a new platform-device instance-id.
> - *
> + * In-Field Scan (IFS) is a hardware feature that runs circuit-level tests on
> + * all CPUs in a group, where all CPUs share the same SCAN test engine to
> + * detect problems that are not caught by parity or ECC checks. Future CPUs
> + * will support more than one type of test, which will show up with a new
> + * platform-device instance-id.
>   *
>   * IFS Image
>   * ---------
> @@ -59,19 +59,19 @@
>   * Running tests
>   * -------------
>   *
> - * Tests are run by the driver synchronizing execution of all threads on a
> - * core and then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
> - * execution continues when:
> + * Tests are run by the driver synchronizing execution of all CPUs in a group
> + * that share the same SCAN test engine, then writing to the ACTIVATE_SCAN MSR
> + * on all CPUs. Instruction execution continues when:
>   *
>   * 1) All tests have completed.
>   * 2) Execution was interrupted.
>   * 3) A test detected a problem.
>   *
> - * Note that ALL THREADS ON THE CORE ARE EFFECTIVELY OFFLINE FOR THE
> + * Note that ALL CPUs IN THE GROUP ARE EFFECTIVELY OFFLINE FOR THE
>   * DURATION OF THE TEST. This can be up to 200 milliseconds. If the system
> - * is running latency sensitive applications that cannot tolerate an
> + * is running latency-sensitive applications that cannot tolerate an
>   * interruption of this magnitude, the system administrator must arrange
> - * to migrate those applications to other cores before running a core test.
> + * to migrate those applications to other CPUs before running a group test.
>   * It may also be necessary to redirect interrupts to other CPUs.
>   *
>   * In all cases reading the corresponding test's STATUS MSR provides details on what
> @@ -81,30 +81,52 @@
>   * The IFS driver provides sysfs interfaces via /sys/devices/virtual/misc/intel_ifs_<n>/
>   * to control execution:
>   *
> - * Test a specific core::
> + * Test a specific group::
>   *
>   *   # echo <CPU#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
>   *
> - * when HT is enabled any of the sibling CPU# can be specified to test
> - * its corresponding physical core. Since the tests are per physical core,
> - * the result of testing any thread is same. All siblings must be online
> - * to run a core test. It is only necessary to test one thread.
> + * Any CPU in the same group that shares the same SCAN test engine can be
> + * specified to test its corresponding group. Offline CPUs in the group do
> + * not take part in the test; if the test then does not pass, the driver
> + * warns. It is only necessary to test one CPU in the group.
>   *
> - * For e.g. to test core corresponding to CPU5
> + * For e.g. to test a group corresponding to CPU5
>   *
>   *   # echo 5 > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
>   *
> - * Results of the last test is provided in /sys::
> + * The result of the last test for the primary CPU in the group is provided in /sys::
>   *
>   *   $ cat /sys/devices/virtual/misc/intel_ifs_<n>/status
>   *   pass
>   *
> - * Status can be one of pass, fail, untested
> + * Status can be one of pass, fail, untested.
>   *
> - * Additional details of the last test is provided by the details file::
> + * Additional details of the last test for the primary CPU in the group are provided in /sys::

Does kerneldoc require long lines for :: ? If not, please reflow to 80 
chars (and all similar cases you touch in this patch).

>   *
>   *   $ cat /sys/devices/virtual/misc/intel_ifs_<n>/details
> - *   0x8081
> + *   0x7f0080
> + *
> + * For intel_ifs_0, there are following additional sysfs files:
> + *
> + * All CPUs in the same group that ran the test are provided in /sys::
> + *
> + *   $ cat /sys/devices/virtual/misc/intel_ifs_0/cpus_ran_list
> + *   5,149
> + *
> + * The results of the last test for all CPUs in the same group are provided in /sys::
> + *
> + *   $ cat /sys/devices/virtual/misc/intel_ifs_0/status_list
> + *   pass pass
> + *
> + * Additional details of the last test for all CPUs in the same group are provided in /sys::
> + *
> + *   $ cat /sys/devices/virtual/misc/intel_ifs_0/details_list
> + *   0x7f0080 0x7f0080
> + *
> + * More additional details of the last test for all CPUs in the same group are provided in /sys::
> + *
> + *   $ cat /sys/devices/virtual/misc/intel_ifs_0/addnl_details_list
> + *   0xc44191a 0xc44191a
>   *
>   * The details file reports the hex value of the test specific status MSR.
>   * Hardware defined error codes are documented in volume 4 of the Intel
> @@ -125,7 +147,7 @@
>   * uses the subrange feature to restart an interrupted test.
>   *
>   * 2) Hardware allows for some number of cores to be tested in parallel.
> - * The driver does not make use of this, it only tests one core at a time.
> + * The driver does not make use of this, it only tests one group at a time.
>   *
>   */
>  #include <linux/device.h>
> 

-- 
 i.

