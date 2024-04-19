Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D3651B6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519131; cv=none; b=kmZV8pNF+7TCA+9hcIJb/0TjnbNRf7+2LUQub0rZgb467Ia0tgmbM3a8AA0SeeTnvF7/wquKT2TxmGSgNEmOHrE/L0SRnY4y1Xv2YP7jFj2jGBqK9G/8Ig7rwN2+9do910rN/+qtIYytI/ImhFo4RoqgLw+Ollm4plOVr/EaG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519131; c=relaxed/simple;
	bh=Htx0ifFgwdiVpnrlHgjjU6ulh8ClnXymx/p2sCYRtKY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From; b=tweM0L04OoucHZOAzIF5Msit5lqHtR+F7l41b9PjGHM4JahVZnPBCB0sPUMEJtZ1ulFsugX8tas6lJgyKfbHlADyptAX0c+OLwHAzAtaupeu/p1XLccrwy2mSgVYG45WOOKx76JND8XcY7cDzgbKEyscjGEsgByQhs7iaqy+HSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMrV0VSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMrV0VSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959E8C116B1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713519131;
	bh=Htx0ifFgwdiVpnrlHgjjU6ulh8ClnXymx/p2sCYRtKY=;
	h=Date:To:Subject:From:From;
	b=RMrV0VSMiRs4tluVicVjnN0k8JVoEad8vSiXW3DhSV+s6DRhuUcF5uzdKeVpZswI+
	 8ogTnY4ugo0MDF+UV4WFg7SXvcuR3e7LC7QqBQA2VSKxymDKzCT6apyeUgjri6h0lL
	 +hun8V5RYOtVjT5XNwiYX0T1J3mxvNNuWl/DzdxHtiY+v47XXDXA41s6rGb4aRFcJh
	 FxJ6YPdzDKnnYvvDLTluP8cgXJrlZMi7YyeFwAjqnMP1MZuvVk1BD49RJ7oqqS4qx8
	 Ajh6dMBTo9ZYzZENN4+leYcs9KmyaNc0hjiBrR9ZEpmQtk0PrblLZSD6YBl4mc0B5k
	 lD22l9YRO0VDQ==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Apr 2024 12:32:08 +0300
Message-Id: <D0NZU4H44AC8.NSG7PEPFEQR8@kernel.org>
To: <linux-trace-kernel@vger.kernel.org>
Subject: timeout triggered probe
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0

Hi

I wonder if there is a way to attach a probe to a timeout in process
context?

This spun off from https://social.kernel.org/notice/Ah18GN3aezWLdcxcAK

Also relevant: https://social.kernel.org/notice/Ah2O2qXO32lPRPQkk4

Maybe there is a way already but being able to do this would have
practical use for sure if it does not.

BR, Jarkko
