Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02612E3E5;
	Fri, 12 Jul 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772700; cv=none; b=fSnf7DEl7V/sx6ppCf7MJzyJv1Tp5oFPxE8+TOtDd+6bl9SqfbUWgr9vqf9wkUkVWJDurjClrUMSJgUE5NYAPSPtc4jkw26FpAauc3KVB+AcWvSGursVTJi8G+DKwc8FId284vy/wZ/toAw1jOu7xX0R9wHK0/XfkTPHhVo3HjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772700; c=relaxed/simple;
	bh=jqB7whlmPkjkPISKRrxB661pfiyQumaj9f4hpEuOymA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pvhkv/6zIWK/4afJ0gG/9U8xh9J1SAFBlo0ntc9ybuli6aoE3i9QRLZUpnK/jpyZDV80+K+LseM0GnB9wANL/XqW5LwxmHSy1VSpj9mPJmYdkVxeobR46ypdXy5vNRefXdfJX/c8/7okEOt3nE0+J0qe/anMbDfBkf3IZdvmwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKBYcyno; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKBYcyno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720772699; x=1752308699;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jqB7whlmPkjkPISKRrxB661pfiyQumaj9f4hpEuOymA=;
  b=HKBYcynouJOS3jOypi4ij5bZnRSJDDnEh+VkGvuete+xqTrh+efpULwA
   rLJxWTZnmTt6j4zTfGzbNOjS7INLBWYtrrkkN5+ARY9bnBIdEIPT9WNA/
   9IqjtwqxxbxTKbUhQwbzzsZ4OZCi2ls4O2gebzU5G81SEyFyBz/X8IU+C
   DYwM+zhIO21OWeMdRwresV6CRpqCGjwEIP4dAIkIBB8S2GifKBAkYmsB6
   Gspu04N0HTvczJUBpaUM6uEPQNAEkFeSSZlZzIW3JZ/qjB+MX/u6nmYAE
   1ybZOVQsXhv/Uo2T48JVtbkaDmNN4vCUPXemCEd2QcyshWRD/Kh7fdumQ
   Q==;
X-CSE-ConnectionGUID: YnkWHIk2TUCyruslavE+Pg==
X-CSE-MsgGUID: WjYzrzeEQuORa9yaZfZ7MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29609946"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29609946"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 01:24:58 -0700
X-CSE-ConnectionGUID: JKHgKo4mR5CO3e2Y6P4gEw==
X-CSE-MsgGUID: k7+U9Z+GR0SMIdNc19bHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53772480"
Received: from unknown (HELO localhost) ([10.245.247.129])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 01:24:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jul 2024 11:24:48 +0300 (EEST)
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
In-Reply-To: <7e1e86b9-9578-441f-9f4a-23c274234344@linux.intel.com>
Message-ID: <d22295d5-2d2d-217b-5676-2743657938cb@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com> <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
 <7e1e86b9-9578-441f-9f4a-23c274234344@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1207419265-1720772688=:1010"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1207419265-1720772688=:1010
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jul 2024, Kuppuswamy Sathyanarayanan wrote:
> On 7/11/24 2:44 AM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 10 Jul 2024, Kuppuswamy Sathyanarayanan wrote:
> >
> >> From: Jithu Joseph <jithu.joseph@intel.com>
> >>
> >> In a core, the SBAF test engine is shared between sibling CPUs.
> >>
> >> An SBAF test image contains multiple bundles. Each bundle is further
> >> composed of subunits called programs. When a SBAF test (for a particul=
ar
> >> core) is triggered by the user, each SBAF bundle from the loaded test
> >> image is executed sequentially on all the threads on the core using
> >> the stop_core_cpuslocked mechanism. Each bundle execution is initiated=
 by
> >> writing to MSR_ACTIVATE_SBAF.
> >>
> >> SBAF test bundle execution may be aborted when an interrupt occurs or
> >> if the CPU does not have enough power budget for the test. In these
> >> cases the kernel restarts the test from the aborted bundle. SBAF
> >> execution is not retried if the test fails or if the test makes no
> >> forward progress after 5 retries.
> >>
> >> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> >> Reviewed-by: Tony Luck <tony.luck@intel.com>
> >> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@=
linux.intel.com>
> >> ---

> >> +static const char * const sbaf_test_status[] =3D {
> >> +=09[IFS_SBAF_NO_ERROR] =3D "SBAF no error",
> >> +=09[IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN] =3D "Other thread could not=
 join.",
> >> +=09[IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS] =3D "Interrupt occurred p=
rior to SBAF coordination.",
> >> +=09[IFS_SBAF_UNASSIGNED_ERROR_CODE3] =3D "Unassigned error code 0x3",
> >> +=09[IFS_SBAF_INVALID_BUNDLE_INDEX] =3D "Non valid sbaf bundles. Reloa=
d test image",
> > Non-valid SBAF
> >
> > ...but given your define is named "INVALID", why not use just Invalid=
=20
> > SBAF?
>=20
> Above string is from the specification document.But I think it is ok to u=
se
> "Invalid" or "Non-valid".
>=20
> Jithu, any concerns?
>=20
> >> +=09[IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS] =3D "Mismatch in argument=
s between threads T0/T1.",
> >> +=09[IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY] =3D "Core not capable of per=
forming SBAF currently",
> >> +=09[IFS_SBAF_UNASSIGNED_ERROR_CODE7] =3D "Unassigned error code 0x7",
> >> +=09[IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT] =3D "Exceeded numbe=
r of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
> >> +=09[IFS_SBAF_INTERRUPTED_DURING_EXECUTION] =3D "Interrupt occurred pr=
ior to SBAF start",
> >> +=09[IFS_SBAF_INVALID_PROGRAM_INDEX] =3D "SBAF program index not valid=
",
> >> +=09[IFS_SBAF_CORRUPTED_CHUNK] =3D "SBAF operation aborted due to corr=
upted chunk",
> >> +=09[IFS_SBAF_DID_NOT_START] =3D "SBAF operation did not start",
> >> +};
> >> +
> >> +static void sbaf_message_not_tested(struct device *dev, int cpu, u64 =
status_data)
> >> +{
> >> +=09union ifs_sbaf_status status =3D (union ifs_sbaf_status)status_dat=
a;
> >> +
> >> +=09if (status.error_code < ARRAY_SIZE(sbaf_test_status)) {
> >> +=09=09dev_info(dev, "CPU(s) %*pbl: SBAF operation did not start. %s\n=
",
> >> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)),
> >> +=09=09=09 sbaf_test_status[status.error_code]);
> >> +=09} else if (status.error_code =3D=3D IFS_SW_TIMEOUT) {
> >> +=09=09dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
> >> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)));
> >> +=09} else if (status.error_code =3D=3D IFS_SW_PARTIAL_COMPLETION) {
> >> +=09=09dev_info(dev, "CPU(s) %*pbl: %s\n",
> >> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)),
> >> +=09=09=09 "Not all SBAF bundles executed. Maximum forward progress re=
tries exceeded");
> >> +=09} else {
> >> +=09=09dev_info(dev, "CPU(s) %*pbl: SBAF unknown status %llx\n",
> >> +=09=09=09 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
> >> +=09}
> >> +}
> >> +
> >> +static void sbaf_message_fail(struct device *dev, int cpu, union ifs_=
sbaf_status status)
> >> +{
> >> +=09/* Failed signature check is set when SBAF signature did not match=
 the expected value */
> >> +=09if (status.sbaf_status =3D=3D SBAF_STATUS_SIGN_FAIL) {
> >> +=09=09dev_err(dev, "CPU(s) %*pbl: Failed signature check\n",
> >> +=09=09=09cpumask_pr_args(cpu_smt_mask(cpu)));
> >> +=09}
> >> +
> >> +=09/* Failed to reach end of test */
> >> +=09if (status.sbaf_status =3D=3D SBAF_STATUS_TEST_FAIL) {
> >> +=09=09dev_err(dev, "CPU(s) %*pbl: Failed to complete test\n",
> >> +=09=09=09cpumask_pr_args(cpu_smt_mask(cpu)));
> >> +=09}
> >> +}
> >> +
> >> +static bool sbaf_bundle_completed(union ifs_sbaf_status status)
> >> +{
> >> +=09if (status.sbaf_status || status.error_code)
> >> +=09=09return false;
> >> +=09return true;
> > This is same as:
> >
> > =09return !status.sbaf_status && !status.error_code;
>=20
> Yes. Your version looks good. Do you want me to send a version with
> this change or you can include it when merging it?

Please do send a new version, there were too many things to change for
me to do it while applying.

--=20
 i.

--8323328-1207419265-1720772688=:1010--
