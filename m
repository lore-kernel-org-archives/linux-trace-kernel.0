Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1A12BF02;
	Thu, 11 Jul 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687881; cv=none; b=jguk4HawblhfkiACOB7EOWZQBCJxpVpcUiC0zpZIlJXPotWIYLfcMOyLov2vgkYYI37XJ7vw49dNvfXb3M1H3fxVBjqtfYd2oinfbSXsxd24/dwoiYM0nAlltaqbWDL2jqM77Fyhx3YtF85wzaKPGoUHu8JV29GPxkmbmSVebKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687881; c=relaxed/simple;
	bh=SaXXZZ6NfZUihrHcuGZXqnfG3tvHnwj/bWlwU85dwM0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a77AfiEbvAHQAwE5uz8/iyNMjGPymSFP2Zu1pl/QGtZm+DrAl9cKdBWKvnQig6H+hVPohSUvdHTaXOnE3begT9Y94BZpwb3g878nOUe163VE9daMp3kuOuOQ3O4FdEDc25rmYscc6ff3UKGnE3lJvqy1MaPJJG+A+6cR23rcpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/AKGMeV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/AKGMeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720687879; x=1752223879;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SaXXZZ6NfZUihrHcuGZXqnfG3tvHnwj/bWlwU85dwM0=;
  b=g/AKGMeVHFayikdaT9El0QGFt8Kkun2jT3qPqeY56FMgpOzjSRmw6WKN
   JaCFaUfR45TtBZy0J4owda4tcJVoT+e2z62xq0oxbAzZKfnGwTWW9HtUu
   4AhAZpT9vPO4bdkvSdwPZ2yE5/1IubJtVLZ4ozJUIvKouweAeq1II98Mo
   poE+gkf22yUaFhKrT8tIs/D6wnLEaV9Y0YPmr8/0UIkqNzNVVjigkaLMB
   UmBFLwuHdAuqF5dqSZAeIycnuIy4IHB8S81pLDuDJePChy9jy6BNxlB+T
   3pzq2Jr7njFQRZ5JXrCeTYnH0ojlz+eY4gmhctHNdWOIC4p/dMAvLSvRa
   A==;
X-CSE-ConnectionGUID: X+98BAbRQJ6TVyfCLSJ4vQ==
X-CSE-MsgGUID: +s9AuHSYQQ6kxHvNxjP9TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21924911"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21924911"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:51:18 -0700
X-CSE-ConnectionGUID: XVz0kAQvQgi09MHDxBP4lQ==
X-CSE-MsgGUID: ONB92p7oTi2G1N318k2SSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48932031"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 01:51:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 11:51:10 +0300 (EEST)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj <ashok.raj@intel.com>, 
    Tony Luck <tony.luck@intel.com>, linux-trace-kernel@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 1/4] platform/x86/intel/ifs: Refactor MSR usage in
 IFS test code
In-Reply-To: <20240711000233.684642-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c6b49d6b-0b1f-07b4-c5ad-a4afd6a39744@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20240711000233.684642-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-263407840-1720687870=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-263407840-1720687870=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Jul 2024, Kuppuswamy Sathyanarayanan wrote:

> IFS tests such as Scan at Field (SAF) or Structural Based Functional
> Test at Field (SBAF), require the user to load a test image. The image
> loading process is similar across these tests, with the only difference
> being MSR addresses used. To reuse the code between these tests, remove
> the hard coding of MSR addresses and allow the driver to pass the MSR
> addresses per IFS test (via driver device data).
>=20
> Add a new structure named "struct ifs_test_msrs" to specify the
> test-specific MSR addresses. Each IFS test will provide this structure,
> enabling them to reuse the common code.
>=20
> This is a preliminary patch in preparation for the addition of SBAF
> support.
>=20
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/intel/ifs/ifs.h  | 25 +++++++++++++++++++++++++
>  drivers/platform/x86/intel/ifs/core.c |  9 +++++++++
>  drivers/platform/x86/intel/ifs/load.c | 24 ++++++++++++++----------
>  3 files changed, 48 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/=
intel/ifs/ifs.h
> index 56b9f3e3cf76..738cbc7a5d00 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -266,6 +266,22 @@ struct ifs_test_caps {
>  =09int=09test_num;
>  };
> =20
> +/**
> + * struct ifs_test_msrs - MSRs used in IFS tests
> + * @copy_hashes: Copy test hash data
> + * @copy_hashes_status: Status of copied test hash data
> + * @copy_chunks: Copy chunks of the test data
> + * @copy_chunks_status: Status of the copied test data chunks
> + * @test_ctrl: Control the test attributes
> + */
> +struct ifs_test_msrs {
> +=09u32=09copy_hashes;
> +=09u32=09copy_hashes_status;
> +=09u32=09copy_chunks;
> +=09u32=09copy_chunks_status;
> +=09u32=09test_ctrl;
> +};
> +
>  /**
>   * struct ifs_data - attributes related to intel IFS driver
>   * @loaded_version: stores the currently loaded ifs image version.
> @@ -299,6 +315,7 @@ struct ifs_work {
> =20
>  struct ifs_device {
>  =09const struct ifs_test_caps *test_caps;
> +=09const struct ifs_test_msrs *test_msrs;
>  =09struct ifs_data rw_data;
>  =09struct miscdevice misc;
>  };
> @@ -319,6 +336,14 @@ static inline const struct ifs_test_caps *ifs_get_te=
st_caps(struct device *dev)
>  =09return d->test_caps;
>  }
> =20
> +static inline const struct ifs_test_msrs *ifs_get_test_msrs(struct devic=
e *dev)
> +{
> +=09struct miscdevice *m =3D dev_get_drvdata(dev);
> +=09struct ifs_device *d =3D container_of(m, struct ifs_device, misc);
> +
> +=09return d->test_msrs;
> +}
> +
>  extern bool *ifs_pkg_auth;
>  int ifs_load_firmware(struct device *dev);
>  int do_core_test(int cpu, struct device *dev);
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86=
/intel/ifs/core.c
> index 7b11198d85a1..1a7ca74abb61 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -40,9 +40,18 @@ static const struct ifs_test_caps array_test =3D {
>  =09.test_num =3D IFS_TYPE_ARRAY_BIST,
>  };
> =20
> +static const struct ifs_test_msrs scan_msrs =3D {
> +=09.copy_hashes =3D MSR_COPY_SCAN_HASHES,
> +=09.copy_hashes_status =3D MSR_SCAN_HASHES_STATUS,
> +=09.copy_chunks =3D MSR_AUTHENTICATE_AND_COPY_CHUNK,
> +=09.copy_chunks_status =3D MSR_CHUNKS_AUTHENTICATION_STATUS,
> +=09.test_ctrl =3D MSR_SAF_CTRL,
> +};
> +
>  static struct ifs_device ifs_devices[] =3D {
>  =09[IFS_TYPE_SAF] =3D {
>  =09=09.test_caps =3D &scan_test,
> +=09=09.test_msrs =3D &scan_msrs,
>  =09=09.misc =3D {
>  =09=09=09.name =3D "intel_ifs_0",
>  =09=09=09.minor =3D MISC_DYNAMIC_MINOR,
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86=
/intel/ifs/load.c
> index 39f19cb51749..ad0c107f0922 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -118,15 +118,17 @@ static void copy_hashes_authenticate_chunks(struct =
work_struct *work)
>  =09union ifs_scan_hashes_status hashes_status;
>  =09union ifs_chunks_auth_status chunk_status;
>  =09struct device *dev =3D local_work->dev;
> +=09const struct ifs_test_msrs *msrs;
>  =09int i, num_chunks, chunk_size;
>  =09struct ifs_data *ifsd;
>  =09u64 linear_addr, base;
>  =09u32 err_code;
> =20
>  =09ifsd =3D ifs_get_data(dev);
> +=09msrs =3D ifs_get_test_msrs(dev);
>  =09/* run scan hash copy */
> -=09wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
> -=09rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
> +=09wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
> +=09rdmsrl(msrs->copy_hashes_status, hashes_status.data);
> =20
>  =09/* enumerate the scan image information */
>  =09num_chunks =3D hashes_status.num_chunks;
> @@ -147,8 +149,8 @@ static void copy_hashes_authenticate_chunks(struct wo=
rk_struct *work)
>  =09=09linear_addr =3D base + i * chunk_size;
>  =09=09linear_addr |=3D i;
> =20
> -=09=09wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, linear_addr);
> -=09=09rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
> +=09=09wrmsrl(msrs->copy_chunks, linear_addr);
> +=09=09rdmsrl(msrs->copy_chunks_status, chunk_status.data);
> =20
>  =09=09ifsd->valid_chunks =3D chunk_status.valid_chunks;
>  =09=09err_code =3D chunk_status.error_code;
> @@ -180,6 +182,7 @@ static int copy_hashes_authenticate_chunks_gen2(struc=
t device *dev)
>  =09union ifs_scan_hashes_status_gen2 hashes_status;
>  =09union ifs_chunks_auth_status_gen2 chunk_status;
>  =09u32 err_code, valid_chunks, total_chunks;
> +=09const struct ifs_test_msrs *msrs;
>  =09int i, num_chunks, chunk_size;
>  =09union meta_data *ifs_meta;
>  =09int starting_chunk_nr;
> @@ -189,10 +192,11 @@ static int copy_hashes_authenticate_chunks_gen2(str=
uct device *dev)
>  =09int retry_count;
> =20
>  =09ifsd =3D ifs_get_data(dev);
> +=09msrs =3D ifs_get_test_msrs(dev);
> =20
>  =09if (need_copy_scan_hashes(ifsd)) {
> -=09=09wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
> -=09=09rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
> +=09=09wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
> +=09=09rdmsrl(msrs->copy_hashes_status, hashes_status.data);
> =20
>  =09=09/* enumerate the scan image information */
>  =09=09chunk_size =3D hashes_status.chunk_size * SZ_1K;
> @@ -212,8 +216,8 @@ static int copy_hashes_authenticate_chunks_gen2(struc=
t device *dev)
>  =09}
> =20
>  =09if (ifsd->generation >=3D IFS_GEN_STRIDE_AWARE) {
> -=09=09wrmsrl(MSR_SAF_CTRL, INVALIDATE_STRIDE);
> -=09=09rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
> +=09=09wrmsrl(msrs->test_ctrl, INVALIDATE_STRIDE);
> +=09=09rdmsrl(msrs->copy_chunks_status, chunk_status.data);
>  =09=09if (chunk_status.valid_chunks !=3D 0) {
>  =09=09=09dev_err(dev, "Couldn't invalidate installed stride - %d\n",
>  =09=09=09=09chunk_status.valid_chunks);
> @@ -234,9 +238,9 @@ static int copy_hashes_authenticate_chunks_gen2(struc=
t device *dev)
>  =09=09chunk_table[1] =3D linear_addr;
>  =09=09do {
>  =09=09=09local_irq_disable();
> -=09=09=09wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, (u64)chunk_table);
> +=09=09=09wrmsrl(msrs->copy_chunks, (u64)chunk_table);
>  =09=09=09local_irq_enable();
> -=09=09=09rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
> +=09=09=09rdmsrl(msrs->copy_chunks_status, chunk_status.data);
>  =09=09=09err_code =3D chunk_status.error_code;
>  =09=09} while (err_code =3D=3D AUTH_INTERRUPTED_ERROR && --retry_count);
> =20
>=20
--8323328-263407840-1720687870=:6262--
