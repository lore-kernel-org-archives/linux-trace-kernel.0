Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436B77115;
	Thu, 11 Jul 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691147; cv=none; b=k7NpL4kqwz1bNh+F47d1T7fJkkpHNqWa9h9GYbIOAxus8LYUxFSedSB6j+es5kPxt3KpLyY1RWJmbuwL/pZrSZxfp5PwX6QI74UwfTmiJFUcpGgOAOlPB+mKbK5XzgyjNMTQzEbmZcOqH9E7bi0FAg9+QPTjcClidA2IcV48Mpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691147; c=relaxed/simple;
	bh=rKam1FYTmykhBK1gQKpwiV97+QhsF3bbdjoPh4/6CxA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uXTC9Xnj6yBgXrw6Obkw/nmHFNIRih25x2T35wWBAz2L9RA5TDESmbHMW0xB2b/evb3BpiKF6O5yMaPYXzxMa4HdbbaVe4rR8DVOAdYhylA4FrSTQeIzZxMJgV70ej8aUC/O+DpO1RhDOpD6qdues8B1WywHguF2kFNkfpDJN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJGkuFCZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJGkuFCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720691146; x=1752227146;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rKam1FYTmykhBK1gQKpwiV97+QhsF3bbdjoPh4/6CxA=;
  b=nJGkuFCZCn5lt24hEkZaMecFqNAewT5r4dOgx67mI7WYI61sEtebD6Gx
   RBiAY2WKGp3CcZY4jvJX9CemxNrjmUzFlv0F+7TSs5wuVm0YQ3K+fO6YZ
   Bh9uuyCBAgch5nkqOvmaGxYmlAhAgHuvC1C7lrVePEG21oIFWxLZ0KpZd
   6WO5jcr/6L/YJrmWGmV7EV1LZG72uc8cheJno8aRAWjNHgU5Uiss3/pSb
   kKDCXWdJPKZfu1A/G5CIZqTLx/Zh7b7S/vomVuXUQbrjzEetksZ63zlBP
   R737EeN953PBztBjer5u0IFGXTPJHr4K+zPj7U8GQUEk2dXEHvMOiIoql
   Q==;
X-CSE-ConnectionGUID: YXWOEUuTQXSRi8sBJee46Q==
X-CSE-MsgGUID: A6TfnlvbRVe9yXXHlwcLuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21875874"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21875874"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:45:45 -0700
X-CSE-ConnectionGUID: 8Z4E5cNrTfWHUqNXkiHw1Q==
X-CSE-MsgGUID: InlzvKUwQy+hLMRmRcpd+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48497007"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.127])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:45:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jul 2024 12:45:36 +0300 (EEST)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj <ashok.raj@intel.com>, 
    Tony Luck <tony.luck@intel.com>, linux-trace-kernel@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 4/4] trace: platform/x86/intel/ifs: Add SBAF trace
 support
In-Reply-To: <20240711000233.684642-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f366f214-8348-ff23-5d3a-1c06fe1abd1a@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20240711000233.684642-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-912915995-1720691136=:6262"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-912915995-1720691136=:6262
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Jul 2024, Kuppuswamy Sathyanarayanan wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
>=20
> Add tracing support for the SBAF IFS tests, which may be useful for
> debugging systems that fail these tests. Log details like test content
> batch number, SBAF bundle ID, program index and the exact errors or
> warnings encountered by each HT thread during the test.
>=20
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-912915995-1720691136=:6262--
