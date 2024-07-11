Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D5653;
	Thu, 11 Jul 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688496; cv=none; b=hB84B1nmNGNi2nZ2Gx28Q2BnPjHfK4/UelnGQZkefm49mz86Kx4Jweh5Z8mm8wlA9zRSJUmujqa+wstMmt3g3qN8aaySjd4fjafwoufDjMjg7SxYOyPtEIP6RznLmYXO8h7tVXasfy9Q7y3NaUGyyY+dFNDMbez9JDMekXOVshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688496; c=relaxed/simple;
	bh=q0Tb+aVh0TKZSUQY8hXHBvnciYKsGTszf4TQaRw8hMY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tiGDpuwX+NaygPolCcWSOjsEZw7VKMPpZ1b8OwtHSaM1XNbtYh0Y/ubWxOYmSKfrbNxPyAoTf6zF99KhdX56hdmMOrm08baFpokhreVe3UuGlXJfGmgyspcUuX9auHENb/4VthBJXkIg9decbmzlk7VcagrXe2THxiF0VxCzHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVqErNEK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVqErNEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720688495; x=1752224495;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q0Tb+aVh0TKZSUQY8hXHBvnciYKsGTszf4TQaRw8hMY=;
  b=iVqErNEKQ3jMdYNDpzympyswONCejUBWgJRuzUcbeEH25lAAn+JXiUwm
   yeKJ23CiLXApYhBg4esMsycyT+0Vi9H73mSVZ3JR0W+umjZBUiVEgMHu2
   GkCQ4xkK+eyXdVfUu52eDZfzTmkK3kkYJn7lSwgoRrgeXL5TUjs4KMegZ
   VO/YEfJFnpaqkNSDfdjbvExWbnUfPGkEHkGfOpNWkGIKjuIhHjfaDUPPl
   OKD2aIO0qVY/WHifRP6mu6e4N0/MfE2GGwkxkmc6j+ZPWsHoThnMRymwR
   PRFwA0jmocwjAxPklfo5Chg7w7AxaHPOXJpOT+x+mIeDyEknUkvk5MKsZ
   g==;
X-CSE-ConnectionGUID: 5hdInVk/Tc++LfRn1QbVNQ==
X-CSE-MsgGUID: chv4380oQMCxVRJc8UVifQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21926713"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21926713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:01:15 -0700
X-CSE-ConnectionGUID: RZbLQWhFSPG9sUDPgYy+qQ==
X-CSE-MsgGUID: hQGpTQy3QCOL3dNIJlGxag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="79207963"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:01:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 12:01:06 +0300 (EEST)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj <ashok.raj@intel.com>, 
    Tony Luck <tony.luck@intel.com>, linux-trace-kernel@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 2/4] platform/x86/intel/ifs: Add SBAF test image
 loading support
In-Reply-To: <20240711000233.684642-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ac7acff0-828e-d0d1-1f42-0c3f5494dd5c@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20240711000233.684642-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1959870306-1720688466=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1959870306-1720688466=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Jul 2024, Kuppuswamy Sathyanarayanan wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
>=20
> Structural Based Functional Test at Field (SBAF) is a new type of
> testing that provides comprehensive core test coverage complementing
> existing IFS tests like Scan at Field (SAF) or ArrayBist.
>=20
> SBAF device will appear as a new device instance (intel_ifs_2) under
> /sys/devices/virtual/misc. The user interaction necessary to load the
> test image and test a particular core is the same as the existing scan
> test (intel_ifs_0).
>=20
> During the loading stage, the driver will look for a file named
> ff-mm-ss-<batch02x>.sbft in the /lib/firmware/intel/ifs_2 directory.
> The hardware interaction needed for loading the image is similar to
> SAF, with the only difference being the MSR addresses used. Reuse the
> SAF image loading code, passing the SBAF-specific MSR addresses via
> struct ifs_test_msrs in the driver device data.
>=20
> Unlike SAF, the SBAF test image chunks are further divided into smaller
> logical entities called bundles. Since the SBAF test is initiated per
> bundle, cache the maximum number of bundles in the current image, which
> is used for iterating through bundles during SBAF test execution.
>=20
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@l=
inux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Although the image_suffix change to the existing code could have been in=20
own patch but this is simple enough change it doesn't hurt that much.

> ---
>  arch/x86/include/asm/msr-index.h      |  2 ++
>  drivers/platform/x86/intel/ifs/ifs.h  | 37 ++++++++++++++++++++++++++-
>  drivers/platform/x86/intel/ifs/core.c | 24 +++++++++++++++++
>  drivers/platform/x86/intel/ifs/load.c | 15 ++++++++---
>  4 files changed, 73 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index e022e6eb766c..503d7acdda3f 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -247,6 +247,8 @@
>  #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_AR=
RAY_BIST_BIT)
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT=094
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST=09BIT(MSR_INTEGRITY_CAPS_PERIOD=
IC_BIST_BIT)
> +#define MSR_INTEGRITY_CAPS_SBAF_BIT=09=098
> +#define MSR_INTEGRITY_CAPS_SBAF=09=09=09BIT(MSR_INTEGRITY_CAPS_SBAF_BIT)
>  #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK=09GENMASK_ULL(10, 9)
> =20
>  #define MSR_LBR_NHM_FROM=09=090x00000680
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/=
intel/ifs/ifs.h
> index 738cbc7a5d00..600bb8a1b285 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -126,11 +126,38 @@
>   * The driver does not make use of this, it only tests one core at a tim=
e.
>   *
>   * .. [#f1] https://github.com/intel/TBD
> + *
> + *
> + * Structural Based Functional Test at Field (SBAF):
> + * ------------------------------------------------
> + *
> + * SBAF is a new type of testing that provides comprehensive core test
> + * coverage complementing Scan at Field (SAF) testing. SBAF mimics the
> + * manufacturing screening environment and leverages the same test suite=
=2E
> + * It makes use of Design For Test (DFT) observation sites and features
> + * to maximize coverage in minimum time.
> + *
> + * Similar to the SAF test, SBAF isolates the core under test from the
> + * rest of the system during execution. Upon completion, the core
> + * seamlessly resets to its pre-test state and resumes normal operation.
> + * Any machine checks or hangs encountered during the test are confined =
to
> + * the isolated core, preventing disruption to the overall system.
> + *
> + * Like the SAF test, the SBAF test is also divided into multiple batche=
s,
> + * and each batch test can take hundreds of milliseconds (100-200 ms) to
> + * complete. If such a lengthy interruption is undesirable, it is
> + * recommended to relocate the time-sensitive applications to other core=
s.
>   */
>  #include <linux/device.h>
>  #include <linux/miscdevice.h>
> =20
>  #define MSR_ARRAY_BIST=09=09=09=090x00000105
> +
> +#define MSR_COPY_SBAF_HASHES=09=09=090x000002b8
> +#define MSR_SBAF_HASHES_STATUS=09=09=090x000002b9
> +#define MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK=090x000002ba
> +#define MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS=090x000002bb
> +
>  #define MSR_COPY_SCAN_HASHES=09=09=090x000002c2
>  #define MSR_SCAN_HASHES_STATUS=09=09=090x000002c3
>  #define MSR_AUTHENTICATE_AND_COPY_CHUNK=09=090x000002c4
> @@ -140,6 +167,7 @@
>  #define MSR_ARRAY_TRIGGER=09=09=090x000002d6
>  #define MSR_ARRAY_STATUS=09=09=090x000002d7
>  #define MSR_SAF_CTRL=09=09=09=090x000004f0
> +#define MSR_SBAF_CTRL=09=09=09=090x000004f8
> =20
>  #define SCAN_NOT_TESTED=09=09=09=090
>  #define SCAN_TEST_PASS=09=09=09=091
> @@ -147,6 +175,7 @@
> =20
>  #define IFS_TYPE_SAF=09=09=090
>  #define IFS_TYPE_ARRAY_BIST=09=091
> +#define IFS_TYPE_SBAF=09=09=092
> =20
>  #define ARRAY_GEN0=09=09=090
>  #define ARRAY_GEN1=09=09=091
> @@ -196,7 +225,8 @@ union ifs_chunks_auth_status_gen2 {
>  =09=09u16=09valid_chunks;
>  =09=09u16=09total_chunks;
>  =09=09u32=09error_code=09:8;
> -=09=09u32=09rsvd2=09=09:24;
> +=09=09u32=09rsvd2=09=09:8;
> +=09=09u32=09max_bundle=09:16;
>  =09};
>  };
> =20
> @@ -261,9 +291,12 @@ union ifs_array {
>  #define IFS_SW_TIMEOUT=09=09=09=090xFD
>  #define IFS_SW_PARTIAL_COMPLETION=09=090xFE
> =20
> +#define IFS_SUFFIX_SZ=09=095
> +
>  struct ifs_test_caps {
>  =09int=09integrity_cap_bit;
>  =09int=09test_num;
> +=09char=09image_suffix[IFS_SUFFIX_SZ];
>  };
> =20
>  /**
> @@ -294,6 +327,7 @@ struct ifs_test_msrs {
>   * @generation: IFS test generation enumerated by hardware
>   * @chunk_size: size of a test chunk
>   * @array_gen: test generation of array test
> + * @max_bundle: maximum bundle index
>   */
>  struct ifs_data {
>  =09int=09loaded_version;
> @@ -306,6 +340,7 @@ struct ifs_data {
>  =09u32=09generation;
>  =09u32=09chunk_size;
>  =09u32=09array_gen;
> +=09u32=09max_bundle;
>  };
> =20
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86=
/intel/ifs/core.c
> index 1a7ca74abb61..4f571b79f028 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -33,6 +33,7 @@ bool *ifs_pkg_auth;
>  static const struct ifs_test_caps scan_test =3D {
>  =09.integrity_cap_bit =3D MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>  =09.test_num =3D IFS_TYPE_SAF,
> +=09.image_suffix =3D "scan",
>  };
> =20
>  static const struct ifs_test_caps array_test =3D {
> @@ -48,6 +49,20 @@ static const struct ifs_test_msrs scan_msrs =3D {
>  =09.test_ctrl =3D MSR_SAF_CTRL,
>  };
> =20
> +static const struct ifs_test_msrs sbaf_msrs =3D {
> +=09.copy_hashes =3D MSR_COPY_SBAF_HASHES,
> +=09.copy_hashes_status =3D MSR_SBAF_HASHES_STATUS,
> +=09.copy_chunks =3D MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK,
> +=09.copy_chunks_status =3D MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS,
> +=09.test_ctrl =3D MSR_SBAF_CTRL,
> +};
> +
> +static const struct ifs_test_caps sbaf_test =3D {
> +=09.integrity_cap_bit =3D MSR_INTEGRITY_CAPS_SBAF_BIT,
> +=09.test_num =3D IFS_TYPE_SBAF,
> +=09.image_suffix =3D "sbft",
> +};
> +
>  static struct ifs_device ifs_devices[] =3D {
>  =09[IFS_TYPE_SAF] =3D {
>  =09=09.test_caps =3D &scan_test,
> @@ -66,6 +81,15 @@ static struct ifs_device ifs_devices[] =3D {
>  =09=09=09.groups =3D plat_ifs_array_groups,
>  =09=09},
>  =09},
> +=09[IFS_TYPE_SBAF] =3D {
> +=09=09.test_caps =3D &sbaf_test,
> +=09=09.test_msrs =3D &sbaf_msrs,
> +=09=09.misc =3D {
> +=09=09=09.name =3D "intel_ifs_2",
> +=09=09=09.minor =3D MISC_DYNAMIC_MINOR,
> +=09=09=09.groups =3D plat_ifs_groups,
> +=09=09},
> +=09},
>  };
> =20
>  #define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86=
/intel/ifs/load.c
> index ad0c107f0922..8f2aded38f1c 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -261,20 +261,22 @@ static int copy_hashes_authenticate_chunks_gen2(str=
uct device *dev)
>  =09=09return -EIO;
>  =09}
>  =09ifsd->valid_chunks =3D valid_chunks;
> +=09ifsd->max_bundle =3D chunk_status.max_bundle;
> =20
>  =09return 0;
>  }
> =20
>  static int validate_ifs_metadata(struct device *dev)
>  {
> +=09const struct ifs_test_caps *test =3D ifs_get_test_caps(dev);
>  =09struct ifs_data *ifsd =3D ifs_get_data(dev);
>  =09union meta_data *ifs_meta;
>  =09char test_file[64];
>  =09int ret =3D -EINVAL;
> =20
> -=09snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
> +=09snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.%s",
>  =09=09 boot_cpu_data.x86, boot_cpu_data.x86_model,
> -=09=09 boot_cpu_data.x86_stepping, ifsd->cur_batch);
> +=09=09 boot_cpu_data.x86_stepping, ifsd->cur_batch, test->image_suffix);
> =20
>  =09ifs_meta =3D (union meta_data *)find_meta_data(ifs_header_ptr, META_T=
YPE_IFS);
>  =09if (!ifs_meta) {
> @@ -304,6 +306,11 @@ static int validate_ifs_metadata(struct device *dev)
>  =09=09return ret;
>  =09}
> =20
> +=09if (ifs_meta->test_type !=3D test->test_num) {
> +=09=09dev_warn(dev, "Metadata test_type %d mismatches with device type\n=
",
> +=09=09=09 ifs_meta->test_type);
> +=09}
> +
>  =09return 0;
>  }
> =20
> @@ -391,9 +398,9 @@ int ifs_load_firmware(struct device *dev)
>  =09char scan_path[64];
>  =09int ret;
> =20
> -=09snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%=
02x.scan",
> +=09snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%=
02x.%s",
>  =09=09 test->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
> -=09=09 boot_cpu_data.x86_stepping, ifsd->cur_batch);
> +=09=09 boot_cpu_data.x86_stepping, ifsd->cur_batch, test->image_suffix);
> =20
>  =09ret =3D request_firmware_direct(&fw, scan_path, dev);
>  =09if (ret) {
>=20

--=20
 i.

--8323328-1959870306-1720688466=:6262--
