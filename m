Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D276034;
	Thu, 11 Jul 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691077; cv=none; b=muUDY5RjQzylNnKZSjwSUqglHaUALSo7ibc811uTr1YNqRntztPRF0BhADt61k8lf/5rK2BEGsTiYKqWl8YL7dxjfaCKzoT0t7zOZJj91nT6kNOL8wxksVHxBRsZlno3g+YRF2Wr5ASMNS3ULQvh+nLCC3iD+nfVNN/QJaWeJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691077; c=relaxed/simple;
	bh=MPRFlC/lzcTXvd4rJ3rg6WFvBrN6JyCgnjhQG3EeYso=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F92IdmCGghENqeV42wF+benFwK/yv+4y6M8fFBSgE4cEP4wiaG3rcDxCbJST4Ya+2J5SvddsACarM1OnHSPjNIjomevEBts/peMTjI/N6OEzev+WzGdnPW5ksEM5XPflmNsXWxguZZH0sPWNNAoA443G7lWljdZ0Wt8k2+vDVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4Ef8iJR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4Ef8iJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720691076; x=1752227076;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MPRFlC/lzcTXvd4rJ3rg6WFvBrN6JyCgnjhQG3EeYso=;
  b=X4Ef8iJRArkYcFfV4mBKCR7q/J/EwAY4vDz7B3YWAW/O7kqYrux2wd1B
   iKE/OGMctRv9liDiA/9oZdk8LcYztcQZEZqetm+sR+uqEC8bq6zGOCu8X
   02ouzvEMbwlmwuW+tDrcRZiti4wuA8NW510YZxKJ3fGsFXjIqkxW5tv9H
   pveF/Cq6nTgiiBcGNAqEoe4wiiC/8kcrjkES7iI0FXFFryQ46nmJplrZA
   BufuNgN+Nl5CWCYW1Bo2/FXrYVPeLovrqF0IgaWaGIdVt7lT5GbuD9An/
   3iZQzD5iYhkVpfZc9+y1yvWIeYmHzz63HWTrPi/TsQkjuvAVHHNWqIxSp
   A==;
X-CSE-ConnectionGUID: 8fy58bfkSzW4toyertgqhw==
X-CSE-MsgGUID: Nu9I+9ERRsyILfmg5HJp2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29211111"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="29211111"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:44:33 -0700
X-CSE-ConnectionGUID: 3ku592bsTLSHusUDiKlubw==
X-CSE-MsgGUID: lu5FYwIARtOa5K2pDwyNSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="53444224"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:44:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 12:44:23 +0300 (EEST)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj <ashok.raj@intel.com>, 
    Tony Luck <tony.luck@intel.com>, linux-trace-kernel@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 3/4] platform/x86/intel/ifs: Add SBAF test support
In-Reply-To: <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-311337465-1720691063=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-311337465-1720691063=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Jul 2024, Kuppuswamy Sathyanarayanan wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
>=20
> In a core, the SBAF test engine is shared between sibling CPUs.
>=20
> An SBAF test image contains multiple bundles. Each bundle is further
> composed of subunits called programs. When a SBAF test (for a particular
> core) is triggered by the user, each SBAF bundle from the loaded test
> image is executed sequentially on all the threads on the core using
> the stop_core_cpuslocked mechanism. Each bundle execution is initiated by
> writing to MSR_ACTIVATE_SBAF.
>=20
> SBAF test bundle execution may be aborted when an interrupt occurs or
> if the CPU does not have enough power budget for the test. In these
> cases the kernel restarts the test from the aborted bundle. SBAF
> execution is not retried if the test fails or if the test makes no
> forward progress after 5 retries.
>=20
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  30 +++
>  drivers/platform/x86/intel/ifs/runtest.c | 234 +++++++++++++++++++++++
>  2 files changed, 264 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/=
intel/ifs/ifs.h
> index 600bb8a1b285..b261be46bce8 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -157,6 +157,8 @@
>  #define MSR_SBAF_HASHES_STATUS=09=09=090x000002b9
>  #define MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK=090x000002ba
>  #define MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS=090x000002bb
> +#define MSR_ACTIVATE_SBAF=09=09=090x000002bc
> +#define MSR_SBAF_STATUS=09=09=09=090x000002bd
> =20
>  #define MSR_COPY_SCAN_HASHES=09=09=090x000002c2
>  #define MSR_SCAN_HASHES_STATUS=09=09=090x000002c3
> @@ -283,6 +285,34 @@ union ifs_array {
>  =09};
>  };
> =20
> +/* MSR_ACTIVATE_SBAF bit fields */
> +union ifs_sbaf {
> +=09u64=09data;
> +=09struct {
> +=09=09u32=09bundle_idx=09:9;
> +=09=09u32=09rsvd1=09=09:5;
> +=09=09u32=09pgm_idx=09=09:2;
> +=09=09u32=09rsvd2=09=09:16;
> +=09=09u32=09delay=09=09:31;
> +=09=09u32=09sigmce=09=09:1;
> +=09};
> +};
> +
> +/* MSR_SBAF_STATUS bit fields */
> +union ifs_sbaf_status {
> +=09u64=09data;
> +=09struct {
> +=09=09u32=09bundle_idx=09:9;
> +=09=09u32=09rsvd1=09=09:5;
> +=09=09u32=09pgm_idx=09=09:2;
> +=09=09u32=09rsvd2=09=09:16;
> +=09=09u32=09error_code=09:8;
> +=09=09u32=09rsvd3=09=09:21;
> +=09=09u32=09test_fail=09:1;
> +=09=09u32=09sbaf_status=09:2;
> +=09};
> +};
> +
>  /*
>   * Driver populated error-codes
>   * 0xFD: Test timed out before completing all the chunks.
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/=
x86/intel/ifs/runtest.c
> index 282e4bfe30da..a812ec7761b9 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -29,6 +29,13 @@ struct run_params {
>  =09union ifs_status status;
>  };
> =20
> +struct sbaf_run_params {
> +=09struct ifs_data *ifsd;
> +=09int *retry_cnt;
> +=09union ifs_sbaf *activate;
> +=09union ifs_sbaf_status status;
> +};
> +
>  /*
>   * Number of TSC cycles that a logical CPU will wait for the other
>   * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
> @@ -146,6 +153,7 @@ static bool can_restart(union ifs_status status)
>  #define SPINUNIT 100 /* 100 nsec */
>  static atomic_t array_cpus_in;
>  static atomic_t scan_cpus_in;
> +static atomic_t sbaf_cpus_in;
> =20
>  /*
>   * Simplified cpu sibling rendezvous loop based on microcode loader __wa=
it_for_cpus()
> @@ -387,6 +395,226 @@ static void ifs_array_test_gen1(int cpu, struct dev=
ice *dev)
>  =09=09ifsd->status =3D SCAN_TEST_PASS;
>  }
> =20
> +#define SBAF_STATUS_PASS=09=09=090
> +#define SBAF_STATUS_SIGN_FAIL=09=09=091
> +#define SBAF_STATUS_INTR=09=09=092
> +#define SBAF_STATUS_TEST_FAIL=09=09=093
> +
> +enum sbaf_status_err_code {
> +=09IFS_SBAF_NO_ERROR=09=09=09=09=3D 0,
> +=09IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN=09=09=3D 1,
> +=09IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS=09=09=3D 2,
> +=09IFS_SBAF_UNASSIGNED_ERROR_CODE3=09=09=09=3D 3,
> +=09IFS_SBAF_INVALID_BUNDLE_INDEX=09=09=09=3D 4,
> +=09IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS=09=09=3D 5,
> +=09IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY=09=09=3D 6,
> +=09IFS_SBAF_UNASSIGNED_ERROR_CODE7=09=09=09=3D 7,
> +=09IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT=09=3D 8,
> +=09IFS_SBAF_INTERRUPTED_DURING_EXECUTION=09=09=3D 9,
> +=09IFS_SBAF_INVALID_PROGRAM_INDEX=09=09=09=3D 0xA,
> +=09IFS_SBAF_CORRUPTED_CHUNK=09=09=09=3D 0xB,
> +=09IFS_SBAF_DID_NOT_START=09=09=09=09=3D 0xC,
> +};
> +
> +static const char * const sbaf_test_status[] =3D {
> +=09[IFS_SBAF_NO_ERROR] =3D "SBAF no error",
> +=09[IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN] =3D "Other thread could not jo=
in.",
> +=09[IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS] =3D "Interrupt occurred prio=
r to SBAF coordination.",
> +=09[IFS_SBAF_UNASSIGNED_ERROR_CODE3] =3D "Unassigned error code 0x3",
> +=09[IFS_SBAF_INVALID_BUNDLE_INDEX] =3D "Non valid sbaf bundles. Reload t=
est image",

Non-valid SBAF

=2E..but given your define is named "INVALID", why not use just Invalid=20
SBAF?

> +=09[IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS] =3D "Mismatch in arguments b=
etween threads T0/T1.",
> +=09[IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY] =3D "Core not capable of perfor=
ming SBAF currently",
> +=09[IFS_SBAF_UNASSIGNED_ERROR_CODE7] =3D "Unassigned error code 0x7",
> +=09[IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT] =3D "Exceeded number o=
f Logical Processors (LP) allowed to run Scan-At-Field concurrently",
> +=09[IFS_SBAF_INTERRUPTED_DURING_EXECUTION] =3D "Interrupt occurred prior=
 to SBAF start",
> +=09[IFS_SBAF_INVALID_PROGRAM_INDEX] =3D "SBAF program index not valid",
> +=09[IFS_SBAF_CORRUPTED_CHUNK] =3D "SBAF operation aborted due to corrupt=
ed chunk",
> +=09[IFS_SBAF_DID_NOT_START] =3D "SBAF operation did not start",
> +};
> +
> +static void sbaf_message_not_tested(struct device *dev, int cpu, u64 sta=
tus_data)
> +{
> +=09union ifs_sbaf_status status =3D (union ifs_sbaf_status)status_data;
> +
> +=09if (status.error_code < ARRAY_SIZE(sbaf_test_status)) {
> +=09=09dev_info(dev, "CPU(s) %*pbl: SBAF operation did not start. %s\n",
> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)),
> +=09=09=09 sbaf_test_status[status.error_code]);
> +=09} else if (status.error_code =3D=3D IFS_SW_TIMEOUT) {
> +=09=09dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)));
> +=09} else if (status.error_code =3D=3D IFS_SW_PARTIAL_COMPLETION) {
> +=09=09dev_info(dev, "CPU(s) %*pbl: %s\n",
> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)),
> +=09=09=09 "Not all SBAF bundles executed. Maximum forward progress retri=
es exceeded");
> +=09} else {
> +=09=09dev_info(dev, "CPU(s) %*pbl: SBAF unknown status %llx\n",
> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
> +=09}
> +}
> +
> +static void sbaf_message_fail(struct device *dev, int cpu, union ifs_sba=
f_status status)
> +{
> +=09/* Failed signature check is set when SBAF signature did not match th=
e expected value */
> +=09if (status.sbaf_status =3D=3D SBAF_STATUS_SIGN_FAIL) {
> +=09=09dev_err(dev, "CPU(s) %*pbl: Failed signature check\n",
> +=09=09=09cpumask_pr_args(cpu_smt_mask(cpu)));
> +=09}
> +
> +=09/* Failed to reach end of test */
> +=09if (status.sbaf_status =3D=3D SBAF_STATUS_TEST_FAIL) {
> +=09=09dev_err(dev, "CPU(s) %*pbl: Failed to complete test\n",
> +=09=09=09cpumask_pr_args(cpu_smt_mask(cpu)));
> +=09}
> +}
> +
> +static bool sbaf_bundle_completed(union ifs_sbaf_status status)
> +{
> +=09if (status.sbaf_status || status.error_code)
> +=09=09return false;
> +=09return true;

This is same as:

=09return !status.sbaf_status && !status.error_code;

> +}
> +
> +static bool sbaf_can_restart(union ifs_sbaf_status status)
> +{
> +=09enum sbaf_status_err_code err_code =3D status.error_code;
> +
> +=09/* Signature for chunk is bad, or scan test failed */
> +=09if (status.sbaf_status =3D=3D SBAF_STATUS_SIGN_FAIL ||
> +=09    status.sbaf_status =3D=3D SBAF_STATUS_TEST_FAIL)
> +=09=09return false;
> +
> +=09switch (err_code) {
> +=09case IFS_SBAF_NO_ERROR:
> +=09case IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN:
> +=09case IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS:
> +=09case IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT:
> +=09case IFS_SBAF_INTERRUPTED_DURING_EXECUTION:
> +=09=09return true;
> +=09case IFS_SBAF_UNASSIGNED_ERROR_CODE3:
> +=09case IFS_SBAF_INVALID_BUNDLE_INDEX:
> +=09case IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS:
> +=09case IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY:
> +=09case IFS_SBAF_UNASSIGNED_ERROR_CODE7:
> +=09case IFS_SBAF_INVALID_PROGRAM_INDEX:
> +=09case IFS_SBAF_CORRUPTED_CHUNK:
> +=09case IFS_SBAF_DID_NOT_START:
> +=09=09break;
> +=09}
> +=09return false;
> +}
> +
> +/*
> + * Execute the SBAF test. Called "simultaneously" on all threads of a co=
re
> + * at high priority using the stop_cpus mechanism.
> + */
> +static int dosbaf(void *data)
> +{
> +=09struct sbaf_run_params *run_params =3D data;
> +=09int cpu =3D smp_processor_id();
> +=09union ifs_sbaf_status status;
> +=09struct ifs_data *ifsd;
> +=09int first;
> +
> +=09ifsd =3D run_params->ifsd;
> +
> +=09/* Only the first logical CPU on a core reports result */
> +=09first =3D cpumask_first(cpu_smt_mask(cpu));
> +=09wait_for_sibling_cpu(&sbaf_cpus_in, NSEC_PER_SEC);
> +
> +=09/*
> +=09 * This WRMSR will wait for other HT threads to also write
> +=09 * to this MSR (at most for activate.delay cycles). Then it
> +=09 * starts scan of each requested bundle. The core test happens
> +=09 * during the "execution" of the WRMSR.
> +=09 */
> +=09wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
> +=09rdmsrl(MSR_SBAF_STATUS, status.data);
> +
> +=09/* Pass back the result of the test */
> +=09if (cpu =3D=3D first)
> +=09=09run_params->status =3D status;
> +
> +=09return 0;
> +}
> +
> +static void ifs_sbaf_test_core(int cpu, struct device *dev)
> +{
> +=09struct sbaf_run_params run_params;
> +=09union ifs_sbaf_status status =3D {};
> +=09union ifs_sbaf activate;
> +=09unsigned long timeout;
> +=09struct ifs_data *ifsd;
> +=09int stop_bundle;
> +=09int retries;
> +
> +=09ifsd =3D ifs_get_data(dev);
> +
> +=09activate.data =3D 0;
> +=09activate.delay =3D IFS_THREAD_WAIT;
> +
> +=09timeout =3D jiffies + (2 * HZ);

Unnecessary parenthesis.

Other than those things mentioned above,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-311337465-1720691063=:6262--
