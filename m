Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97867169397;
	Wed,  9 Oct 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516366; cv=none; b=uFat2z0lQakGicPfjryAV9PlvTEB0olOgKwgt4p2QIeIPwdJqRaat57ufSas9GrRMPS25loLbwSB+5Cxc9bJM/WlOAj7I5MV+AHG1Fy86XK5YTqYYcXkC34gsKLkxGkVyGTzNGQq2pWgTaHeVa17Pv+j2u9jSkPMTkMd5Pf9uKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516366; c=relaxed/simple;
	bh=f64Yhdqvt9fSYnm4Yfzsu4rGlDlrRpczGLMoVJNvLds=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KhYJ+PTOm8VTjYIjuYMblP/ow6cUJNH9fdBkUAGvLza78gRHFuOPPjySEm+gm3qllvnePRPPGTnrxVgwSNp5g072gdOabhXvr19Yxysd6qa2sCiLCsrkExQdYL6EydrfI5IxNfh4t+qvAbFBTZdSVLkFOg4CTUs0Bs8JVE+tii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxxS3HoA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxxS3HoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55796C4CEC3;
	Wed,  9 Oct 2024 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728516366;
	bh=f64Yhdqvt9fSYnm4Yfzsu4rGlDlrRpczGLMoVJNvLds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxxS3HoARoSEkdVgh8OcIQKPBWS0DCVDRHNCNwt2ktrU1QHFFyfmQaes+uYLbQ6rc
	 U6GqmU92a4YTXsFKusTE6Nn1vq4Wd6tiNbdfUWA1dLfp+/Ixgy6AM3oCLfudsmRTai
	 eCtNxxt64y+gBR5yeOqRS+LcAM7mxKzZG6X+ZoJWdm3Em9RtDJUhqZIjIlDGedDXnS
	 RsbXJbnbmarbuWJ/HXBzJylxqkt6w4WNZDPzcH6P0iLjbzMgTb32f1AF1VJglK+3t+
	 Bq/3fQL2ID6w4l0j+MHapj1feimnHy7GSQ8e7tmmjzCdKhrz29scUSSNMWcKaRv3ZR
	 1/R6Df2UgOXFw==
Date: Thu, 10 Oct 2024 08:26:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and
 printing the function return address
Message-Id: <20241010082602.9d5d191b686f5a9ac7eca4c3@kernel.org>
In-Reply-To: <20241009131920.2afaf15f@gandalf.local.home>
References: <20241009030340.16400-1-dolinux.peng@gmail.com>
	<20241010013222.3748287f165e9f874eda0f84@kernel.org>
	<20241009131920.2afaf15f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 13:19:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Hi Masami,
> 
> Care to send this as a real patch?

Yes, let me send it.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
