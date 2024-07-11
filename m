Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8AA16A382;
	Thu, 11 Jul 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740310; cv=none; b=b5yU4Dxbm2coJcwts9N30ZxwBxrCvuE+99oOiMbuCEkzNnCdvkAsgnfNubtFeuJgPLdzMIKVMgoZ6/zUxTUNEY5qIvhSMWSTfYdfTQguEFRrrY2EaR8n7DEV4/9lMnnnBtrK/sI50FRmTh4tAlP/t4gBxmu0A6JLvtUx65WZ/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740310; c=relaxed/simple;
	bh=O+gs07KNn0HdsNt8uk18GVj+jW6iv3pJrWaD/t+HDZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buQTrlp5zdyWeCgarg36RdNlq1n+mnfrhXDUP7NHjDvMQvHFcrBDYydQKuz6Ry5VPflrjG3QIzAXJmeDlUgnlK++PWtIQNPUhpuHZQV0n+sW8XwOQ4XcDw02l5xMPEkV9IXGWoki8IDpEIl4ree0twShd4g7qyAjeM7xBVa9/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1590C116B1;
	Thu, 11 Jul 2024 23:25:08 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:26:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj
 <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-trace-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 4/4] trace: platform/x86/intel/ifs: Add SBAF trace
 support
Message-ID: <20240711192631.3c48c4bf@gandalf.local.home>
In-Reply-To: <20240711000233.684642-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
	<20240711000233.684642-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 17:02:33 -0700
Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> Add tracing support for the SBAF IFS tests, which may be useful for
> debugging systems that fail these tests. Log details like test content
> batch number, SBAF bundle ID, program index and the exact errors or
> warnings encountered by each HT thread during the test.
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/trace/events/intel_ifs.h         | 27 ++++++++++++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c |  1 +
>  2 files changed, 28 insertions(+)
